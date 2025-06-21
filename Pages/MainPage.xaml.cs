using EcommerceApp.Models;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;

namespace EcommerceApp;

public partial class MainPage : ContentPage
{
	private FirebaseAuthService _authService;
	private FirebaseProductService _productService;
	private CartService _cartService;
	private ObservableCollection<ProductViewModel> _summerSaleProducts;
	private ObservableCollection<ProductViewModel> _newArrivalProducts;
	private int _cartItemCount;

	public MainPage()
	{
		InitializeComponent();
		_summerSaleProducts = new ObservableCollection<ProductViewModel>();
		_newArrivalProducts = new ObservableCollection<ProductViewModel>();
		_cartItemCount = 0;
		
		BindingContext = this;
		_ = LoadProductsAsync();
		_ = LoadCartCountAsync();
	}

	protected override async void OnAppearing()
	{
		base.OnAppearing();
		// Reîncarcă numărul de produse din coș când utilizatorul revine la această pagină
		await LoadCartCountAsync();
	}

	public ObservableCollection<ProductViewModel> SummerSaleProducts => _summerSaleProducts;
	public ObservableCollection<ProductViewModel> NewArrivalProducts => _newArrivalProducts;
	public int CartItemCount => _cartItemCount;
	public bool HasCartItems => _cartItemCount > 0;

	private async Task LoadProductsAsync()
	{
		try
		{
			// Așteptăm să ne asigurăm că Firebase este inițializat
			await FirebaseConfig.InitializeFirestoreAsync();
			
			_authService = new FirebaseAuthService();
			_productService = new FirebaseProductService();
			
			var allProducts = await _productService.GetAllProductsAsync();
			
			// Produse pentru Summer Sale (primele 3)
			var summerSaleProducts = allProducts.Take(3).Select(p => new ProductViewModel(p, 20)).ToList();

			// Produse pentru New Arrivals (următoarele 3)
			var newArrivalProducts = allProducts.Skip(3).Take(3).Select(p => new ProductViewModel(p)).ToList();

			// Actualizăm UI-ul pe thread-ul principal
			MainThread.BeginInvokeOnMainThread(() =>
			{
				_summerSaleProducts.Clear();
				foreach (var product in summerSaleProducts)
				{
					_summerSaleProducts.Add(product);
				}

				_newArrivalProducts.Clear();
				foreach (var product in newArrivalProducts)
				{
					_newArrivalProducts.Add(product);
				}

				OnPropertyChanged(nameof(SummerSaleProducts));
				OnPropertyChanged(nameof(NewArrivalProducts));
			});
		}
		catch (Exception ex)
		{
			System.Diagnostics.Debug.WriteLine($"Error loading products: {ex.Message}");
			await MainThread.InvokeOnMainThreadAsync(() =>
			{
				DisplayAlert("Error", "Could not load products. Please check your internet connection.", "OK");
			});
		}
	}

	private async Task LoadCartCountAsync()
	{
		try
		{
			if (_authService.IsAuthenticated)
			{
				await _cartService.LoadCartForCurrentUserAsync();
				_cartItemCount = _cartService.GetCartItemCount();
			}
			else
			{
				_cartItemCount = 0;
			}
			
			MainThread.BeginInvokeOnMainThread(() =>
			{
				OnPropertyChanged(nameof(CartItemCount));
				OnPropertyChanged(nameof(HasCartItems));
			});
		}
		catch (Exception ex)
		{
			System.Diagnostics.Debug.WriteLine($"Error loading cart count: {ex.Message}");
		}
	}

	private async Task AddSampleProductsAsync()
	{
		var sampleProducts = new List<Product>
		{
			new Product 
			{ 
				Name = "Nike Air Max 270", 
				Description = "Comfortable running shoes with Air Max technology", 
				Price = 129.99, 
				Brand = "Nike", 
				Category = "Shoes",
				ImageUrl = "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400",
				Colors = new List<string> { "Black", "White", "Red" },
				Sizes = new List<string> { "7", "8", "9", "10", "11" }
			},
			new Product 
			{ 
				Name = "Adidas Ultraboost 21", 
				Description = "Premium running shoes with Boost technology", 
				Price = 179.99, 
				Brand = "Adidas", 
				Category = "Shoes",
				ImageUrl = "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400",
				Colors = new List<string> { "Blue", "Grey", "Black" },
				Sizes = new List<string> { "7", "8", "9", "10", "11" }
			},
			new Product 
			{ 
				Name = "Puma RS-X", 
				Description = "Retro-inspired sneakers with bold design", 
				Price = 89.99, 
				Brand = "Puma", 
				Category = "Shoes",
				ImageUrl = "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=400",
				Colors = new List<string> { "White", "Pink", "Yellow" },
				Sizes = new List<string> { "7", "8", "9", "10", "11" }
			},
			new Product 
			{ 
				Name = "Levi's 501 Jeans", 
				Description = "Classic straight fit jeans", 
				Price = 79.99, 
				Brand = "Levi's", 
				Category = "Clothing",
				ImageUrl = "https://images.unsplash.com/photo-1542272604-787c3835535d?w=400",
				Colors = new List<string> { "Blue", "Black", "Grey" },
				Sizes = new List<string> { "30", "32", "34", "36", "38" }
			},
			new Product 
			{ 
				Name = "H&M T-Shirt", 
				Description = "Comfortable cotton t-shirt", 
				Price = 19.99, 
				Brand = "H&M", 
				Category = "Clothing",
				ImageUrl = "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400",
				Colors = new List<string> { "White", "Black", "Grey", "Blue" },
				Sizes = new List<string> { "S", "M", "L", "XL" }
			},
			new Product 
			{ 
				Name = "Zara Blazer", 
				Description = "Elegant blazer for formal occasions", 
				Price = 149.99, 
				Brand = "Zara", 
				Category = "Clothing",
				ImageUrl = "https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=400",
				Colors = new List<string> { "Black", "Navy", "Grey" },
				Sizes = new List<string> { "S", "M", "L", "XL" }
			}
		};

		foreach (var product in sampleProducts)
		{
			await _productService.AddProductAsync(product);
		}
	}

	private async void OnShowAllSummerSale(object sender, EventArgs e)
	{
		await Navigation.PushAsync(new StorePage());
	}

	private async void OnShowAllNewArrivals(object sender, EventArgs e)
	{
		await Navigation.PushAsync(new StorePage());
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

	private async void OnFavoriteClicked(object sender, EventArgs e)
	{
		await Navigation.PushAsync(App.ServiceProvider.GetRequiredService<FavoritesPage>());
    }

	private async void OnProfileClicked(object sender, EventArgs e)
	{
        await Navigation.PushAsync(App.ServiceProvider.GetRequiredService<ProfilePage>());
    }

	private async void OnProductTapped(object sender, TappedEventArgs e)
	{
		if (e.Parameter is ProductViewModel productVM)
		{
			var allProducts = await _productService.GetAllProductsAsync();
			var product = allProducts.FirstOrDefault(p => p.Id == productVM.Id);
			if (product != null)
			{
				await Navigation.PushAsync(new ProductDetailsPage(product));
			}
		}
	}

	public class ProductViewModel
	{
		public string Name { get; set; }
		public string Description { get; set; }
		public string ImageUrl { get; set; }
		public double Price { get; set; }
		public double OldPrice { get; set; }
		public int DiscountPercent { get; set; }
		public string Brand { get; set; }
		public string Category { get; set; }
		public string Id { get; set; }

		public ProductViewModel(Product p, int discountPercent = 0)
		{
			Id = p.Id;
			Name = p.Name;
			Description = p.Description;
			ImageUrl = p.ImageUrl;
			OldPrice = p.Price;
			DiscountPercent = discountPercent;
			Price = discountPercent > 0 ? System.Math.Round(p.Price * (1 - discountPercent / 100.0), 2) : p.Price;
			Brand = p.Brand;
			Category = p.Category;
		}
	}
}

