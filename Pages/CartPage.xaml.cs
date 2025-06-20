using EcommerceApp.Models;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;
using System.Collections.Generic;
using System.Linq;

namespace EcommerceApp;

public partial class CartPage : ContentPage
{
    private FirebaseAuthService _authService;
    private CartService _cartService;
    private List<CartItem> _cartItems;

    public CartPage(FirebaseAuthService authService, CartService cartService)
    {
        InitializeComponent();
        _cartItems = new List<CartItem>();
        _authService = authService;
        _cartService = cartService;
        // Nu inițializa serviciile aici!
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();

        try
        {
            await LoadCartItemsAsync();
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", ex.Message, "OK");
        }
    }


    private async Task LoadCartItemsAsync()
    {
        try
        {
            if (_authService.IsAuthenticated)
            {
                await _cartService.LoadCartForCurrentUserAsync();
                _cartItems = _cartService.GetCartItems();
            }
            else
            {
                _cartItems = new List<CartItem>();
                await DisplayAlert("Authentication Required", "Please sign in to view your cart", "OK");
                await Navigation.PopAsync();
                return;
            }

            UpdateCartDisplay();
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", "Failed to load cart items", "OK");
            System.Diagnostics.Debug.WriteLine($"Error loading cart: {ex.Message}");
        }
    }

    private void UpdateCartDisplay()
    {
        if (_cartItems.Any())
        {
            var displayItems = _cartItems.Select(item => new CartDisplayItem
            {
                Id = item.Id,
                ProductName = item.ProductName,
                Brand = "Lacoste",
                Color = "Light Orange",
                Size = "S",
                ImageUrl = item.ImageUrl,
                Price = item.Price,
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
                var cartItem = _cartItems.FirstOrDefault(x => x.Id == item.Id);
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
                    await LoadCartItemsAsync();
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
                var cartItem = _cartItems.FirstOrDefault(x => x.Id == item.Id);
                if (cartItem != null)
                {
                    await _cartService.UpdateQuantityAsync(_authService.UserId, item.Id, cartItem.Quantity + 1);
                    await LoadCartItemsAsync();
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
                    await LoadCartItemsAsync();
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
        if (_cartItems.Any())
        {
            await Navigation.PushAsync(new CheckoutPage(_cartItems));
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