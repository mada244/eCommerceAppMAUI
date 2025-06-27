using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Maui.Storage;
using System.IO;
using Newtonsoft.Json;

namespace EcommerceApp.Services
{
    public class FirebaseAuthService
    {
        private const string ApiKey = ""; 
        private static readonly HttpClient _httpClient = new HttpClient();
        
        public string AuthToken { get; private set; }
        public string UserId { get; private set; }
        public string UserEmail { get; private set; }
        public bool IsAuthenticated => !string.IsNullOrEmpty(AuthToken);

        public FirebaseAuthService()
        {
           
        }
        
        public async Task<bool> SignInAsync(string email, string password)
        {
            try
            {
                var request = new
                {
                    email = email,
                    password = password,
                    returnSecureToken = true
                };
                
                var json = System.Text.Json.JsonSerializer.Serialize(request);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                
                var response = await _httpClient.PostAsync(
                    $"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={ApiKey}", 
                    content);
                
                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var deserializationOptions = new JsonSerializerOptions()
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var authResponse = System.Text.Json.JsonSerializer.Deserialize<FirebaseAuthResponse>(responseContent, deserializationOptions);
                    
                    if (authResponse != null)
                    {
                        AuthToken = authResponse.IdToken;
                        UserId = authResponse.LocalId;
                        UserEmail = authResponse.Email;
                        
                        return true;
                    }
                }
                
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Firebase Auth Error: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> SignUpAsync(string email, string password)
        {
            try
            {
                var request = new
                {
                    email = email,
                    password = password,
                    returnSecureToken = true
                };
                
                var json = System.Text.Json.JsonSerializer.Serialize(request);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                
                var response = await _httpClient.PostAsync(
                    $"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key={ApiKey}", 
                    content);
                
                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var authResponse = System.Text.Json.JsonSerializer.Deserialize<FirebaseAuthResponse>(responseContent);
                    
                    if (authResponse != null)
                    {
                        AuthToken = authResponse.IdToken;
                        UserId = authResponse.LocalId;
                        UserEmail = authResponse.Email;
                        
                        return true;
                    }
                }
                
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Firebase Auth Error: {ex.Message}");
                return false;
            }
        }


        public async Task<bool> SendPasswordResetEmailAsync(string email)
        {
            try
            {
                var request = new
                {
                    requestType = "PASSWORD_RESET",
                    email = email
                };
                
                var json = System.Text.Json.JsonSerializer.Serialize(request);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                
                var response = await _httpClient.PostAsync(
                    $"https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key={ApiKey}", 
                    content);
                
                if (response.IsSuccessStatusCode)
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    var resetResponse = System.Text.Json.JsonSerializer.Deserialize<FirebasePasswordResetResponse>(responseContent);
                    
                    return resetResponse != null && !string.IsNullOrEmpty(resetResponse.Email);
                }
                
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Firebase Password Reset Error: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> RefreshTokenIfNeededAsync()
        {
            if (string.IsNullOrEmpty(AuthToken))
            {
                return false;
            }

            return true;
        }
    }

    public class FirebaseAuthResponse
    {
        [JsonProperty("kind")]
        public string Kind { get; set; }

        [JsonProperty("localId")]
        public string LocalId { get; set; }

        [JsonProperty("email")]
        public string Email { get; set; }

        [JsonProperty("displayName")]
        public string DisplayName { get; set; }

        [JsonProperty("idToken")]
        public string IdToken { get; set; }

        [JsonProperty("registered")]
        public bool Registered { get; set; }

        [JsonProperty("refreshToken")]
        public string RefreshToken { get; set; }

        [JsonProperty("expiresIn")]
        public string ExpiresIn { get; set; }
    }

    public class FirebasePasswordResetResponse
    {
        public string Email { get; set; }
        public string RequestType { get; set; }
    }

    public class AuthState
    {
        public string AuthToken { get; set; }
        public string UserId { get; set; }
        public string UserEmail { get; set; }
    }
}
