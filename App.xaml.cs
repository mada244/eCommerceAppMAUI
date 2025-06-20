using EcommerceApp.Services;
using System.Threading.Tasks;

namespace EcommerceApp;

public partial class App : Application
{
    public static IServiceProvider ServiceProvider { get; private set; }
    public App(IServiceProvider serviceProvider)
	{
        ServiceProvider = serviceProvider;
        InitializeComponent();
		// Inițializez pagina principală cu un loader temporar
		MainPage = new ContentPage { Content = new ActivityIndicator { IsRunning = true, VerticalOptions = LayoutOptions.Center, HorizontalOptions = LayoutOptions.Center } };
		_ = InitializeAppAsync();
	}

	private async Task InitializeAppAsync()
	{

        var authService = new FirebaseAuthService();
		if (authService.IsAuthenticated)
		{
			MainThread.BeginInvokeOnMainThread(() =>
			{
				MainPage = new NavigationPage(new MainPage());
			});
		}
		else
		{
			MainThread.BeginInvokeOnMainThread(() =>
			{
				MainPage = new NavigationPage(ServiceProvider.GetRequiredService<SignInPage>());
			});
		}
	}
}
