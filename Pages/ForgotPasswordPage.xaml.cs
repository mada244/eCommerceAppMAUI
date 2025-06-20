using Microsoft.Maui.Controls;
using EcommerceApp.Services;

namespace EcommerceApp;

public partial class ForgotPasswordPage : ContentPage
{
    private FirebaseAuthService _authService;

    public ForgotPasswordPage()
    {
        InitializeComponent();
        _authService = new FirebaseAuthService();
    }

    private async void OnResetPasswordClicked(object sender, EventArgs e)
    {
        string email = EmailEntry.Text?.Trim();

        if (string.IsNullOrEmpty(email))
        {
            await DisplayAlert("Error", "Please enter your email address", "OK");
            return;
        }

        if (!IsValidEmail(email))
        {
            await DisplayAlert("Error", "Please enter a valid email address", "OK");
            return;
        }

        try
        {
            // Dezactivăm butonul în timpul procesului
            ResetPasswordButton.IsEnabled = false;
            ResetPasswordButton.Text = "Sending...";

            var success = await _authService.SendPasswordResetEmailAsync(email);
            
            if (success)
            {
                await DisplayAlert("Success", 
                    "Password reset email sent! Please check your inbox and follow the instructions to reset your password.", 
                    "OK");
                await Navigation.PopAsync();
            }
            else
            {
                await DisplayAlert("Error", 
                    "Failed to send reset email. Please check if the email address is correct and try again.", 
                    "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            // Reactivăm butonul
            ResetPasswordButton.IsEnabled = true;
            ResetPasswordButton.Text = "Send Reset Link";
        }
    }

    private async void OnBackToSignInTapped(object sender, TappedEventArgs e)
    {
        await Navigation.PopAsync();
    }

    private bool IsValidEmail(string email)
    {
        try
        {
            var addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }
} 