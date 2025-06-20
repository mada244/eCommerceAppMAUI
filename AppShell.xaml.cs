namespace EcommerceApp;
using EcommerceApp.Services;
using Microsoft.Maui.Controls;

public partial class AppShell : Shell
{
	public AppShell()
	{
		InitializeComponent();
	}

	private async void OnProfileClicked(object sender, EventArgs e)
	{
		var authService = (FirebaseAuthService)App.Current.Handler.MauiContext.Services.GetService(typeof(FirebaseAuthService));
		await Navigation.PushAsync(new ProfilePage(authService));
	}
}
