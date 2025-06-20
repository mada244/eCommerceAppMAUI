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

        builder.Services.AddSingleton<SignInPage>();
        builder.Services.AddSingleton<CartPage>();
		builder.Services.AddSingleton<FavoritesPage>();
		builder.Services.AddSingleton<MainPage>();
		builder.Services.AddSingleton<StorePage>();
        return builder.Build();
	}
}
