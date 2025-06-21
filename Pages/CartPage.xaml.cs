using EcommerceApp.Models;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;
using System.Collections.Generic;
using System.Linq;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace EcommerceApp;

public partial class CartPage : ContentPage, INotifyPropertyChanged
{
    private FirebaseAuthService _authService;
    private CartService _cartService;
    public ObservableCollection<CartItem> CartItems { get; set; } = new ObservableCollection<CartItem>();
    private ObservableCollection<Product> _cartProducts;
    public ObservableCollection<Product> CartProducts
    {
        get => _cartProducts;
        set
        {
            if (_cartProducts != value)
            {
                _cartProducts = value;
                OnPropertyChanged(nameof(CartProducts));
                UpdateEmptyStateVisibility();
            }
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;
    protected virtual void OnPropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    public CartPage(FirebaseAuthService authService, CartService cartService)
    {
        InitializeComponent();
        _authService = authService;
        _cartService = cartService;
        CartProducts = _cartService.CartProduct;
        BindingContext = this;
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        if (_authService.IsAuthenticated)
        {
            await _cartService.LoadCartForCurrentUserAsync();
            OnPropertyChanged(nameof(CartProducts));
        }
        UpdateEmptyStateVisibility();
    }

    private void UpdateEmptyStateVisibility()
    {
        if (EmptyCartLayout != null && CartListView != null)
        {
            bool isEmpty = CartProducts == null || CartProducts.Count == 0;
            EmptyCartLayout.IsVisible = isEmpty;
            CartListView.IsVisible = !isEmpty;
        }
    }

    private async Task LoadCartFromFirebase()
    {
        if (_authService.IsAuthenticated)
        {
            await _cartService.LoadCartForCurrentUserAsync();
            CartItems.Clear();
            foreach (var item in _cartService.GetCartItems())
            {
                CartItems.Add(item);
            }
            OnPropertyChanged(nameof(CartItems));
        }
    }

    private async void OnAddToCartClicked(object sender, EventArgs e)
    {
        // Exemplu: productId, quantity
        // await _cartService.AddToCartForCurrentUserAsync(productId, quantity);
        // await LoadCartFromFirebase();
    }

    private async void OnRemoveFromCartClicked(object sender, EventArgs e)
    {
        // Exemplu: productId
        // await _cartService.RemoveFromCartAsync(_authService.UserId, productId);
        // await LoadCartFromFirebase();
    }

    private async void OnUpdateQuantityClicked(object sender, EventArgs e)
    {
        // Exemplu: productId, newQuantity
        // await _cartService.UpdateQuantityAsync(_authService.UserId, productId, newQuantity);
        // await LoadCartFromFirebase();
    }

    private void UpdateCartDisplay()
    {
        if (CartItems.Any())
        {
            var displayItems = CartItems.Select(item => new CartDisplayItem
            {
                Id = item.ProductId,
                Quantity = item.Quantity
            }).ToList();
            CartListView.ItemsSource = displayItems;
            CartListView.IsVisible = true;
            EmptyCartLayout.IsVisible = false;
            UpdateTotals(displayItems);
        }
        else
        {
            CartListView.IsVisible = false;
            EmptyCartLayout.IsVisible = true;
            SubTotalLabel.Text = "$0.00";
            DiscountLabel.Text = "$0.00";
            NetAmountLabel.Text = "$0.00";
        }
    }

    private void UpdateTotals(List<CartDisplayItem> items)
    {
        double subtotal = items.Sum(i => i.Price * i.Quantity);
        double discount = System.Math.Round(subtotal * 0.1, 2); // 10% discount
        double net = subtotal - discount;
        SubTotalLabel.Text = $"${subtotal:0.00}";
        DiscountLabel.Text = $"- ${discount:0.00}";
        NetAmountLabel.Text = $"${net:0.00}";
    }

    private async void OnDecreaseQuantityClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is CartDisplayItem item)
        {
            try
            {
                var cartItem = CartItems.FirstOrDefault(x => x.ProductId == item.Id);
                if (cartItem != null)
                {
                    if (cartItem.Quantity > 1)
                    {
                        await _cartService.UpdateQuantityAsync(_authService.UserId, item.Id, cartItem.Quantity - 1);
                    }
                    else
                    {
                        await _cartService.RemoveFromCartAsync(_authService.UserId, item.Id);
                    }
                    await LoadCartFromFirebase();
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "Failed to update quantity", "OK");
                System.Diagnostics.Debug.WriteLine($"Error updating quantity: {ex.Message}");
            }
        }
    }

    private async void OnIncreaseQuantityClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is CartDisplayItem item)
        {
            try
            {
                var cartItem = CartItems.FirstOrDefault(x => x.ProductId == item.Id);
                if (cartItem != null)
                {
                    await _cartService.UpdateQuantityAsync(_authService.UserId, item.Id, cartItem.Quantity + 1);
                    await LoadCartFromFirebase();
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "Failed to update quantity", "OK");
                System.Diagnostics.Debug.WriteLine($"Error updating quantity: {ex.Message}");
            }
        }
    }

    private async void OnRemoveItemClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is CartDisplayItem item)
        {
            var result = await DisplayAlert("Remove Item", $"Are you sure you want to remove {item.ProductName}?", "Yes", "No");
            if (result)
            {
                try
                {
                    await _cartService.RemoveFromCartAsync(_authService.UserId, item.Id);
                    await LoadCartFromFirebase();
                }
                catch (Exception ex)
                {
                    await DisplayAlert("Error", "Failed to remove item", "OK");
                    System.Diagnostics.Debug.WriteLine($"Error removing item: {ex.Message}");
                }
            }
        }
    }

    private async void OnHomeClicked(object sender, EventArgs e)
    {
        await Navigation.PopToRootAsync();
    }

    private async void OnStoreClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new StorePage());
    }

    private async void OnFavoriteClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(App.ServiceProvider.GetRequiredService<FavoritesPage>());
    }

    private async void OnCartClicked(object sender, EventArgs e)
    {
        // Deja pe pagina de cart
    }

    private async void OnCheckoutClicked(object sender, EventArgs e)
    {
        if (CartItems.Any())
        {
            await Navigation.PushAsync(new CheckoutPage(CartItems.ToList()));
        }
        else
        {
            await DisplayAlert("Empty Cart", "Your cart is empty!", "OK");
        }
    }

    private async void OnBackClicked(object sender, EventArgs e)
    {
        await Navigation.PopAsync();
    }

    private void OnPlaceOrderClicked(object sender, EventArgs e)
    {
        // Handler gol pentru compatibilitate XAML
    }

    private async void OnProfileClicked(object sender, EventArgs e)
    {
        var authService = (FirebaseAuthService)Handler.MauiContext.Services.GetService(typeof(FirebaseAuthService));
        await Navigation.PushAsync(new ProfilePage(authService));
    }

    public class CartDisplayItem
    {
        public string Id { get; set; }
        public string ProductName { get; set; }
        public string Brand { get; set; }
        public string Color { get; set; }
        public string Size { get; set; }
        public string ImageUrl { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }
    }
}