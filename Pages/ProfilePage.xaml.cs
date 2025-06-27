using Microsoft.Maui.Controls;
using EcommerceApp.Services;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace EcommerceApp;

public partial class ProfilePage : ContentPage, INotifyPropertyChanged
{
    private readonly FirebaseAuthService _authService;

    public string _userName;
    public string _userEmail;
    private bool _isAuthenticated;

    public string UserName
    {
        get => _userName;
        set
        {
            _userName = value;
            OnPropertyChanged();
        }
    }

    public string UserEmail
    {
        get => _userEmail;
        set
        {
            _userEmail = value;
            OnPropertyChanged();
        }
    }

    public bool IsAuthenticated
    {
        get => _isAuthenticated;
        set
        {
            _isAuthenticated = value;
            OnPropertyChanged();
        }
    }

    public ProfilePage(FirebaseAuthService authService)
    {
        InitializeComponent();
        _authService = authService;
        BindingContext = this;
        LoadUserProfile();
    }

    private async void LoadUserProfile()
    {
        //await _authService.LoadAuthStateAsync();

        if (_authService.IsAuthenticated)
        {
            UserName = _authService.UserId; 
            UserEmail = _authService.UserEmail;
            IsAuthenticated = true;
        }
        else
        {
            UserName = "Guest";
            UserEmail = "Not logged in";
            IsAuthenticated = false;
        }
    }

    private async void OnSignOutClicked(object sender, EventArgs e)
    {
        //_authService.SignOut();
        await DisplayAlert("Sign Out", "You have been signed out.", "OK");

        // Reset profile
        UserName = "Guest";
        UserEmail = "Not logged in";
        IsAuthenticated = false;
    }

    #region INotifyPropertyChanged Implementation
    public new event PropertyChangedEventHandler PropertyChanged;

    protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
    #endregion


protected override async void OnAppearing()
    {
        base.OnAppearing();
        //await _authService.LoadAuthStateAsync();

        if (_authService.IsAuthenticated)
        {
            UserEmail = _authService.UserEmail ?? "Email not available";
            UserName = UserEmail.Contains("@") ? UserEmail.Split('@')[0] : "Guest";
        }
        else
        {
            UserEmail = "Not logged in";
            UserName = "Guest";
        }

        OnPropertyChanged(nameof(UserEmail));
        OnPropertyChanged(nameof(UserName));
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
        // Deja pe pagina de profil
    }

    private async void OnLogoutClicked(object sender, EventArgs e)
    {
        var result = await DisplayAlert("Logout", "Are you sure you want to logout?", "Yes", "No");
        if (result)
        {
            //_authService.SignOut();
            var signInPage = App.ServiceProvider.GetRequiredService<SignInPage>();
            Application.Current.MainPage = new NavigationPage(signInPage);
        }
    }
} 