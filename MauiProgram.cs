using Google;
using Microsoft.Extensions.Logging;
using EcommerceApp.Services;

namespace EcommerceApp;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

#if DEBUG
		builder.Logging.AddDebug();

#endif

        // Register services
        builder.Services.AddSingleton<FirebaseAuthService>();
        builder.Services.AddSingleton<CartService>();
        builder.Services.AddSingleton<FavoriteService>();
        builder.Services.AddSingleton<FirebaseProductService>();
        builder.Services.AddSingleton<StripeService>();
        builder.Services.AddSingleton<OrderService>();
        builder.Services.AddSingleton<UserService>();

        builder.Services.AddTransient<SignInPage>();
        builder.Services.AddTransient<CartPage>();
		builder.Services.AddTransient<FavoritesPage>();
		builder.Services.AddTransient<MainPage>();
		builder.Services.AddTransient<StorePage>();
        return builder.Build();
	}
}
