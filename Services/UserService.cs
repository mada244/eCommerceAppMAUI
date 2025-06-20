using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;

namespace EcommerceApp.Services
{
    public class UserService
    {
        private static string FileName => Path.Combine(FileSystem.AppDataDirectory, "users.json");
        private List<User> _users = new();
        public User? CurrentUser { get; private set; }

        public UserService()
        {
            LoadUsers();
        }

        public bool Register(string email, string password, string name)
        {
            if (_users.Any(u => u.Email == email))
                return false;
            var user = new User { Email = email, Password = password, Name = name };
            _users.Add(user);
            SaveUsers();
            return true;
        }

        public bool Login(string email, string password)
        {
            var user = _users.FirstOrDefault(u => u.Email == email && u.Password == password);
            if (user != null)
            {
                CurrentUser = user;
                return true;
            }
            return false;
        }

        public void Logout()
        {
            CurrentUser = null;
        }

        public User? GetUserById(string id) => _users.FirstOrDefault(u => u.Id == id);

        private void LoadUsers()
        {
            if (File.Exists(FileName))
            {
                var json = File.ReadAllText(FileName);
                List<User>? list = JsonSerializer.Deserialize<List<User>>(json);
                if (list != null)
                    _users = list;
            }
            else
            {
                _users = new();
            }
        }

        private void SaveUsers()
        {
            var json = JsonSerializer.Serialize(_users);
            File.WriteAllText(FileName, json);
        }
    }
} 