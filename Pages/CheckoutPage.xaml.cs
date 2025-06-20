using EcommerceApp.Models;
using EcommerceApp.Services;

namespace EcommerceApp;

public partial class CheckoutPage : ContentPage
{
	private FirebaseAuthService _authService;
	private StripeService _stripeService;
	private List<CartItem> _cartItems;

	public CheckoutPage(List<CartItem> cartItems)
	{
		InitializeComponent();
		_authService = new FirebaseAuthService();
		_stripeService = new StripeService();
		_cartItems = cartItems ?? new List<CartItem>();
		
		LoadOrderSummary();
		PreFillUserData();
	}

	private void LoadOrderSummary()
	{
		OrderItemsView.ItemsSource = _cartItems;
		var total = _cartItems.Sum(item => item.Price * item.Quantity);
		TotalLabel.Text = $"${total:F2}";
	}

	private void PreFillUserData()
	{
		// Pre-fill with authenticated user data if available
		if (_authService.IsAuthenticated)
		{
			// Note: Firebase Auth doesn't store name by default, so we'll leave it empty
			// Email could be retrieved from Firebase Auth if needed
		}
	}

	private async void OnPlaceOrderClicked(object sender, EventArgs e)
	{
		// Validate form
		if (string.IsNullOrWhiteSpace(NameEntry.Text) ||
			string.IsNullOrWhiteSpace(AddressEntry.Text) ||
			string.IsNullOrWhiteSpace(CityEntry.Text) ||
			string.IsNullOrWhiteSpace(PhoneEntry.Text) ||
			string.IsNullOrWhiteSpace(EmailEntry.Text) ||
			string.IsNullOrWhiteSpace(CardNumberEntry.Text) ||
			string.IsNullOrWhiteSpace(ExpiryEntry.Text) ||
			string.IsNullOrWhiteSpace(CVVEntry.Text))
		{
			await DisplayAlert("Error", "Please fill in all fields!", "OK");
			return;
		}

		// Validate card number format
		if (!IsValidCardNumber(CardNumberEntry.Text))
		{
			await DisplayAlert("Error", "Please enter a valid card number!", "OK");
			return;
		}

		// Validate expiry date
		if (!IsValidExpiryDate(ExpiryEntry.Text))
		{
			await DisplayAlert("Error", "Please enter a valid expiry date (MM/YY)!", "OK");
			return;
		}

		try
		{
			// Show loading
			PlaceOrderButton.IsEnabled = false;
			PlaceOrderButton.Text = "Processing...";

			// Create order
			var order = new Order
			{
				UserId = _authService.UserId ?? "anonymous",
				Items = new List<CartItem>(_cartItems),
				TotalAmount = _cartItems.Sum(item => item.Price * item.Quantity),
				Status = "Pending",
				ShippingAddress = $"{AddressEntry.Text}, {CityEntry.Text}",
				PhoneNumber = PhoneEntry.Text,
				OrderDate = DateTime.Now
			};

			// Process payment with Stripe
			var expiryParts = ExpiryEntry.Text.Split('/');
			var expMonth = expiryParts[0];
			var expYear = "20" + expiryParts[1];

			var paymentSuccess = await _stripeService.ProcessPaymentAsync(
				order, 
				CardNumberEntry.Text, 
				expMonth, 
				expYear, 
				CVVEntry.Text
			);

			if (paymentSuccess)
			{
				order.Status = "Paid";
				// Here you would save the order to Firebase
				// await _orderService.AddOrderAsync(order);

				await DisplayAlert("Success", "Payment processed successfully! Your order has been placed.", "OK");
				
				// Navigate back to main page
				await Navigation.PopToRootAsync();
			}
			else
			{
				await DisplayAlert("Error", "Payment failed. Please check your card details and try again.", "OK");
			}
		}
		catch (Exception ex)
		{
			await DisplayAlert("Error", $"Failed to process payment: {ex.Message}", "OK");
		}
		finally
		{
			// Reset button
			PlaceOrderButton.IsEnabled = true;
			PlaceOrderButton.Text = "Place Order";
		}
	}

	private bool IsValidCardNumber(string cardNumber)
	{
		// Remove spaces and dashes
		cardNumber = cardNumber.Replace(" ", "").Replace("-", "");
		
		// Check if it's a valid length (13-19 digits)
		if (cardNumber.Length < 13 || cardNumber.Length > 19)
			return false;

		// Check if it contains only digits
		if (!cardNumber.All(char.IsDigit))
			return false;

		// Luhn algorithm for card validation
		int sum = 0;
		bool alternate = false;
		
		for (int i = cardNumber.Length - 1; i >= 0; i--)
		{
			int n = int.Parse(cardNumber[i].ToString());
			if (alternate)
			{
				n *= 2;
				if (n > 9)
				{
					n = (n % 10) + 1;
				}
			}
			sum += n;
			alternate = !alternate;
		}
		
		return (sum % 10 == 0);
	}

	private bool IsValidExpiryDate(string expiryDate)
	{
		// Format should be MM/YY
		if (!expiryDate.Contains("/"))
			return false;

		var parts = expiryDate.Split('/');
		if (parts.Length != 2)
			return false;

		if (!int.TryParse(parts[0], out int month) || !int.TryParse(parts[1], out int year))
			return false;

		// Check month range
		if (month < 1 || month > 12)
			return false;

		// Check if card is expired
		var currentDate = DateTime.Now;
		var cardExpiry = new DateTime(2000 + year, month, 1).AddMonths(1).AddDays(-1);
		
		return cardExpiry > currentDate;
	}

	private async void OnBackClicked(object sender, EventArgs e)
	{
		await Navigation.PopAsync();
	}
} 