using Microsoft.Maui.Controls;
using EcommerceApp.Services;

namespace EcommerceApp;

public partial class RegisterPage : ContentPage
{
    private FirebaseAuthService _authService;
    private bool _isPasswordVisible = false;

    public RegisterPage()
    {
        InitializeComponent();
        _authService = new FirebaseAuthService();
        var tap = new TapGestureRecognizer();
        tap.Tapped += OnSignInTapped;
        SignInLabel.GestureRecognizers.Add(tap);
    }

    private void OnTogglePasswordVisibility(object sender, EventArgs e)
    {
        _isPasswordVisible = !_isPasswordVisible;
        PasswordEntry.IsPassword = !_isPasswordVisible;
    }

    private async void OnRegisterClicked(object sender, EventArgs e)
    {
        string firstName = FirstNameEntry.Text;
        string lastName = LastNameEntry.Text;
        string email = EmailEntry.Text;
        string password = PasswordEntry.Text;

        if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            await DisplayAlert("Error", "Please fill in all fields", "OK");
            return;
        }

        if (password.Length < 6)
        {
            await DisplayAlert("Error", "Password must be at least 6 characters long", "OK");
            return;
        }

        try
        {
            var success = await _authService.SignUpAsync(email, password);
            if (success)
            {
                await DisplayAlert("Success", "Registration successful! Please sign in.", "OK");
                await Navigation.PopAsync();
            }
            else
            {
                await DisplayAlert("Error", "Registration failed. Email might already exist.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Registration error: {ex.Message}", "OK");
        }
    }

    private async void OnSignInTapped(object sender, TappedEventArgs e)
    {
        await Navigation.PopAsync();
    }
} 