using EcommerceApp.Models;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;

namespace EcommerceApp;

public partial class StorePage : ContentPage
{
	private FirebaseAuthService? _authService;
	private FirebaseProductService? _productService;
	private CartService _cartService;
	private FavoriteService _favoriteService;
	private ObservableCollection<Product> _products;
	private string _currentCategory = "All";

	public StorePage()
	{
		InitializeComponent();
		_products = new ObservableCollection<Product>();
		BindingContext = this;
	}

	protected override async void OnAppearing()
	{
		base.OnAppearing();

		var serviceProvider = Application.Current?.Handler?.MauiContext?.Services;
		if (serviceProvider == null)
		{
			await DisplayAlert("Error", "Service provider not available!", "OK");
			return;
		}

		_authService ??= (FirebaseAuthService)serviceProvider.GetService(typeof(FirebaseAuthService));
		_productService ??= (FirebaseProductService)serviceProvider.GetService(typeof(FirebaseProductService));
		_cartService ??= (CartService)serviceProvider.GetService(typeof(CartService));
		_favoriteService ??= (FavoriteService)serviceProvider.GetService(typeof(FavoriteService));

		if (_authService != null)
		{
			//await _authService.LoadAuthStateAsync();
		}

		await LoadProductsAsync();
	}

	public ObservableCollection<Product> Products => _products;

	private async Task LoadProductsAsync()
	{
		try
		{
			if (_productService == null)
			{
				await DisplayAlert("Error", "Product service not initialized", "OK");
				return;
			}

			_products.Clear();
			var allProducts = await _productService.GetAllProductsAsync();
			foreach (var product in allProducts)
			{
				_products.Add(product);
			}
		}
		catch (Exception ex)
		{
			await DisplayAlert("Error", "Failed to load products", "OK");
			System.Diagnostics.Debug.WriteLine($"Error loading products: {ex.Message}");
		}
	}

	private void OnSearchTextChanged(object sender, TextChangedEventArgs e)
	{
		// TODO: Implement search functionality
		_ = LoadProductsAsync();
	}

	private async void OnProductTapped(object sender, TappedEventArgs e)
	{
		if (e.Parameter is Product product)
		{
			await Navigation.PushAsync(new ProductDetailsPage(product));
		}
	}

	private async void OnAddToCartClicked(object sender, EventArgs e)
	{
		if (sender is Button button && button.CommandParameter is Product product)
		{
			if (_authService?.IsAuthenticated == true)
			{
				try
				{
                    await _cartService.AddToCartAsync(_authService.UserId, product.Id, 1);
                    await DisplayAlert("Success", "Product added to cart!", "OK");
				}
				catch (Exception ex)
				{
					await DisplayAlert("Error", "Failed to add to cart", "OK");
					System.Diagnostics.Debug.WriteLine($"Error adding to cart: {ex.Message}");
				}
			}
			else
			{
				await DisplayAlert("Authentication Required", "Please sign in to add to cart!", "OK");
			}
		}
	}

	private async void OnFavoriteClicked(object sender, EventArgs e)
	{
		if (sender is Button button && button.CommandParameter is Product product)
		{
			if (_authService?.IsAuthenticated == true)
			{
				try
				{
					//await _favoriteService?.LoadFavoritesForCurrentUserAsync();
					var isFavorite = _favoriteService?.IsFavorite(product.Id) == true;
					if (isFavorite)
					{
						await _favoriteService.RemoveFromFavoritesAsync(_authService.UserId,product.Id);
						await DisplayAlert("Removed", "Product removed from favorites", "OK");
					}
					else
					{
						await _favoriteService.AddToFavoritesAsync(_authService.UserId, product.Id);
						await DisplayAlert("Added", "Product added to favorites", "OK");
					}
				}
				catch (Exception ex)
				{
					await DisplayAlert("Error", "Failed to update favorites", "OK");
					System.Diagnostics.Debug.WriteLine($"Error updating favorites: {ex.Message}");
				}
			}
			else
			{
				await DisplayAlert("Authentication Required", "Please sign in to add favorites!", "OK");
			}
		}
	}

	private async void OnHomeClicked(object sender, EventArgs e)
	{
		await Navigation.PopAsync();
	}

	private async void OnStoreClicked(object sender, EventArgs e)
	{

	}

	private async void OnCartClicked(object sender, EventArgs e)
	{
        await Navigation.PushAsync(App.ServiceProvider.GetRequiredService<CartPage>());
    }

	private async void OnProfileClicked(object sender, EventArgs e)
	{
		var authService = (FirebaseAuthService)Handler.MauiContext.Services.GetService(typeof(FirebaseAuthService));
		await Navigation.PushAsync(new ProfilePage(authService));
	}
} 