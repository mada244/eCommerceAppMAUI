using EcommerceApp.Models;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;

namespace EcommerceApp;

public partial class ProductDetailsPage : ContentPage
{
	private Product _product;
	private FirebaseAuthService? _authService;
	private CartService _cartService;
	private FavoriteService? _favoriteService;
	private ObservableCollection<string> _imageUrls;
	private ObservableCollection<string> _colors;
	private ObservableCollection<string> _sizes;
	private string _selectedColor;
	private string _selectedSize;
	private string _selectedImage;
	private bool _isFavorite;
	private int _quantity = 1;

	public ProductDetailsPage(Product product)
	{
		InitializeComponent();
		_product = product;
		_imageUrls = new ObservableCollection<string>();
		_colors = new ObservableCollection<string>();
		_sizes = new ObservableCollection<string>();
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
		_cartService ??= (CartService)serviceProvider.GetService(typeof(CartService));
		_favoriteService ??= (FavoriteService)serviceProvider.GetService(typeof(FavoriteService));
		if (_authService != null)
		{
			//await _authService.LoadAuthStateAsync();
		}
		await LoadProductDataAsync();
	}

	public string Name => _product.Name;
	public string Description => _product.Description;
	public string Brand => _product.Brand;
	public double Price => _product.Price;
	public double OldPrice => _product.Price * 1.2; // 20% discount
	public int DiscountPercent => 20;
	public bool HasDiscount => true;
	public string FavoriteIcon => _isFavorite ? "❤️" : "🤍";
	public ObservableCollection<string> ImageUrls => _imageUrls;
	public ObservableCollection<string> Colors => _colors;
	public ObservableCollection<string> Sizes => _sizes;
	
	public string SelectedImage
	{
		get => _selectedImage;
		set
		{
			_selectedImage = value;
			OnPropertyChanged();
		}
	}
	
	public string SelectedColor
	{
		get => _selectedColor;
		set
		{
			_selectedColor = value;
			OnPropertyChanged();
		}
	}
	
	public string SelectedSize
	{
		get => _selectedSize;
		set
		{
			_selectedSize = value;
			OnPropertyChanged();
		}
	}
	
	public int Quantity
	{
		get => _quantity;
		set
		{
			_quantity = value;
			OnPropertyChanged();
		}
	}

	private async Task LoadProductDataAsync()
	{
		try
		{
			_imageUrls.Add(_product.ImageUrl);

			if (_product.ImageUrl != null)
			{
				_imageUrls.Add(_product.ImageUrl);
				_imageUrls.Add(_product.ImageUrl);
			}
			
			SelectedImage = _imageUrls.FirstOrDefault();
			
			if (_product.Colors != null && _product.Colors.Any())
			{
				foreach (var color in _product.Colors)
				{
					_colors.Add(color);
				}
			}
			else
			{
				_colors.Add("Red");
				_colors.Add("Blue");
				_colors.Add("Green");
				_colors.Add("Black");
			}
			SelectedColor = _colors.FirstOrDefault();
			
			if (_product.Sizes != null && _product.Sizes.Any())
			{
				foreach (var size in _product.Sizes)
				{
					_sizes.Add(size);
				}
			}
			else
			{
				// Mărimi default
				_sizes.Add("S");
				_sizes.Add("M");
				_sizes.Add("L");
				_sizes.Add("XL");
			}
			SelectedSize = _sizes.FirstOrDefault();
			
			// Verific dacă produsul este în favorite
			if (_authService?.IsAuthenticated == true)
			{
				try
				{
					//await _favoriteService?.GetFavoriteProductsAsync();
					_isFavorite = _favoriteService?.IsFavorite(_product.Id) == true;
					OnPropertyChanged(nameof(FavoriteIcon));
				}
				catch (Exception ex)
				{
					System.Diagnostics.Debug.WriteLine($"Error checking favorite status: {ex.Message}");
				}
			}
		}
		catch (Exception ex)
		{
			System.Diagnostics.Debug.WriteLine($"Error loading product data: {ex.Message}");
		}
	}

	private async void OnBackClicked(object sender, TappedEventArgs e)
	{
		await Navigation.PopAsync();
	}

	private async void OnFavoriteClicked(object sender, EventArgs e)
	{
		if (_authService?.IsAuthenticated == true)
		{
			try
			{
				if (_isFavorite)
				{
					await _favoriteService?.RemoveFromFavoritesAsync(_authService.UserId,_product.Id);
					await DisplayAlert("Removed", "Product removed from favorites", "OK");
				}
				else
				{
					await _favoriteService.AddToFavoritesAsync(_authService.UserId, _product.Id);
					await DisplayAlert("Added", "Product added to favorites", "OK");
				}
				
				_isFavorite = !_isFavorite;
				OnPropertyChanged(nameof(FavoriteIcon));
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

	private void OnDecreaseQuantityClicked(object sender, EventArgs e)
	{
		if (Quantity > 1)
		{
			Quantity--;
		}
	}

	private void OnIncreaseQuantityClicked(object sender, EventArgs e)
	{
		if (Quantity < 10) // Limitare la 10 produse
		{
			Quantity++;
		}
	}

	private async void OnAddToCartClicked(object sender, EventArgs e)
	{
		if (_authService?.IsAuthenticated == true)
		{
			try
			{
				await _cartService.AddToCartAsync(_authService.UserId, _product.Id, Quantity);

                var button = sender as Button;
				if (button != null)
				{
					button.Text = "Added!";
					button.BackgroundColor = Microsoft.Maui.Graphics.Colors.Green;
					
					await Task.Delay(2000);
					button.Text = "Add to Cart";
					button.BackgroundColor = Microsoft.Maui.Graphics.Color.FromArgb("#E91E63"); 
				}
				
				await DisplayAlert("Success", $"Added {Quantity} item(s) to cart!", "OK");
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

	private async void OnHomeClicked(object sender, EventArgs e)
	{
		await Navigation.PopToRootAsync();
	}

	private async void OnStoreClicked(object sender, EventArgs e)
	{
		await Navigation.PushAsync(new StorePage());
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

	private async void OnFavoriteTapped(object sender, EventArgs e)
	{
		await Navigation.PushAsync(App.ServiceProvider.GetRequiredService<FavoritesPage>());
    }
} 