using EcommerceApp.Services;
using Microsoft.Maui.Controls;

namespace EcommerceApp;

public partial class SignInPage : ContentPage
{
    private bool _isPasswordVisible = false;
    private UserService? _userService;
    private FirebaseAuthService? _authService;
    private FirebaseProductService? _productService;
    private CartService? _cartService;

    public SignInPage(FirebaseAuthService authService)
    {
        InitializeComponent();
        _authService = authService;
        var tap = new TapGestureRecognizer();
        tap.Tapped += OnSignUpTapped;
        this.FindByName<Label>("SignUpLabel")?.GestureRecognizers.Add(tap);
    }

    private void OnTogglePasswordVisibility(object sender, EventArgs e)
    {
        _isPasswordVisible = !_isPasswordVisible;
        PasswordEntry.IsPassword = !_isPasswordVisible;
        ShowHideButton.Text = _isPasswordVisible ? "Hide" : "Show";
    }

    private async void OnSignInClicked(object sender, EventArgs e)
    {
        try
        {
            //TODO: remove hardcoded login
            string email = EmailEntry.Text ?? "test99@gmail.com";
            string password = PasswordEntry.Text ?? "test99";

            // Verific dacă email-ul și parola sunt completate
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                await DisplayAlert("Error", "Please enter both email and password", "OK");
                return;
            }

            // Inițializez serviciul de autentificare dacă nu există

            bool success = await _authService.SignInAsync(email, password);
            if (success)
            {
                // Inițializez Firebase și serviciile după autentificare reușită
                await FirebaseConfig.InitializeFirestoreAsync();
                _userService = new UserService();
                _productService = new FirebaseProductService();

                // Navighez către pagina principală
                Application.Current.MainPage = new NavigationPage(new MainPage());
            }
            else
            {
                await DisplayAlert("Error", "Invalid email or password", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", "An error occurred during sign in. Please try again.", "OK");
            System.Diagnostics.Debug.WriteLine($"Sign in error: {ex.Message}");
        }
    }

    private async void OnSignUpTapped(object sender, TappedEventArgs e)
    {
        await Navigation.PushAsync(new RegisterPage());
    }

    private async void OnForgotPasswordClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new ForgotPasswordPage());
    }
}