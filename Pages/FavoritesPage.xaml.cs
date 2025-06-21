using Microsoft.Maui.Controls;
using EcommerceApp.Services;
using EcommerceApp.Models;
using System.Collections.Generic;
using System.Linq;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace EcommerceApp;

public partial class FavoritesPage : ContentPage, INotifyPropertyChanged
{
    private FirebaseAuthService _authService;
    private FavoriteService _favoriteService;
    public ObservableCollection<Favorite> Favorites { get; set; } = new ObservableCollection<Favorite>();
    private ObservableCollection<Product> _favoriteProducts;
    public ObservableCollection<Product> FavoriteProducts
    {
        get => _favoriteProducts;
        set
        {
            if (_favoriteProducts != value)
            {
                _favoriteProducts = value;
                OnPropertyChanged(nameof(FavoriteProducts));
                UpdateEmptyStateVisibility();
            }
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;
    protected virtual void OnPropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    public FavoritesPage(FirebaseAuthService authService, FavoriteService favoriteService)
    {
        InitializeComponent();
        _authService = authService;
        _favoriteService = favoriteService;
        FavoriteProducts = _favoriteService.FavoriteProducts;
        BindingContext = this;
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        if (_authService.IsAuthenticated)
        {
            await _favoriteService.LoadFavoritesAsync(_authService.UserId);
            OnPropertyChanged(nameof(FavoriteProducts));
        }
        UpdateEmptyStateVisibility();
    }

    private void UpdateEmptyStateVisibility()
    {
        if (EmptyFavoritesLayout != null && FavoriteProductsView != null)
        {
            bool isEmpty = FavoriteProducts == null || FavoriteProducts.Count == 0;
            EmptyFavoritesLayout.IsVisible = isEmpty;
            FavoriteProductsView.IsVisible = !isEmpty;
        }
    }

    private async void OnAddToFavoritesClicked(object sender, EventArgs e)
    {
        // Exemplu: productId, productName, price, imageUrl
        // await _favoriteService.AddToFavoritesForCurrentUserAsync(productId, productName, price, imageUrl);
        // await LoadFavoritesFromFirebase();
    }

    private async void OnRemoveFavoriteClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is FavoriteDisplayItem item)
        {
            await _favoriteService.RemoveFromFavoritesForCurrentUserAsync(item.ProductId);
            await _favoriteService.LoadFavoritesAsync(_authService.UserId);
            OnPropertyChanged(nameof(FavoriteProducts));
        }
    }

    private async void OnAddToCartClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is FavoriteDisplayItem item)
        {
            try
            {
                var cartService = Handler.MauiContext.Services.GetService<CartService>();
                if (cartService != null)
                {
                    await cartService.LoadCartForCurrentUserAsync();
                    await DisplayAlert("Success", $"{item.ProductName} added to cart!", "OK");
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "Failed to add to cart", "OK");
                System.Diagnostics.Debug.WriteLine($"Error adding to cart: {ex.Message}");
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
        // Deja pe pagina de favorite
    }

    private async void OnCartClicked(object sender, EventArgs e)
    {
        var cartpg = App.ServiceProvider.GetRequiredService<CartPage>();
        await Navigation.PushAsync(cartpg);
    }

    private async void OnProfileClicked(object sender, EventArgs e)
    {
        var authService = (FirebaseAuthService)Handler.MauiContext.Services.GetService(typeof(FirebaseAuthService));
        await Navigation.PushAsync(new ProfilePage(authService));
    }

    private async void OnBackClicked(object sender, EventArgs e)
    {
        await Navigation.PopAsync();
    }

    public class FavoriteDisplayItem
    {
        public string Id { get; set; }
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public string Brand { get; set; }
        public string Color { get; set; }
        public string Size { get; set; }
        public string ImageUrl { get; set; }
        public double Price { get; set; }
    }
} 