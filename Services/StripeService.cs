using Stripe;
using EcommerceApp.Models;

namespace EcommerceApp.Services
{
    public class StripeService
    {
        private const string StripeSecretKey = "sk_test_..."; // Înlocuiește cu cheia ta Stripe Secret Key
        private const string StripePublishableKey = "pk_test_..."; // Înlocuiește cu cheia ta Stripe Publishable Key

        public StripeService()
        {
            StripeConfiguration.ApiKey = StripeSecretKey;
        }

        public async Task<PaymentIntent> CreatePaymentIntentAsync(double amount, string currency = "usd")
        {
            try
            {
                var options = new PaymentIntentCreateOptions
                {
                    Amount = (long)(amount * 100), // Stripe folosește cenți
                    Currency = currency,
                    AutomaticPaymentMethods = new PaymentIntentAutomaticPaymentMethodsOptions
                    {
                        Enabled = true,
                    },
                };

                var service = new PaymentIntentService();
                return await service.CreateAsync(options);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating payment intent: {ex.Message}");
                throw;
            }
        }

        public async Task<PaymentIntent> ConfirmPaymentIntentAsync(string paymentIntentId, string paymentMethodId)
        {
            try
            {
                var options = new PaymentIntentConfirmOptions
                {
                    PaymentMethod = paymentMethodId,
                };

                var service = new PaymentIntentService();
                return await service.ConfirmAsync(paymentIntentId, options);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error confirming payment intent: {ex.Message}");
                throw;
            }
        }

        public async Task<PaymentIntent> GetPaymentIntentAsync(string paymentIntentId)
        {
            try
            {
                var service = new PaymentIntentService();
                return await service.GetAsync(paymentIntentId);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting payment intent: {ex.Message}");
                throw;
            }
        }

        public async Task<Customer> CreateCustomerAsync(string email, string name)
        {
            try
            {
                var options = new CustomerCreateOptions
                {
                    Email = email,
                    Name = name,
                };

                var service = new CustomerService();
                return await service.CreateAsync(options);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating customer: {ex.Message}");
                throw;
            }
        }

        public async Task<PaymentMethod> CreatePaymentMethodAsync(string cardNumber, string expMonth, string expYear, string cvc)
        {
            try
            {
                var options = new PaymentMethodCreateOptions
                {
                    Type = "card",
                    Card = new PaymentMethodCardOptions
                    {
                        Number = cardNumber,
                        ExpMonth = long.Parse(expMonth),
                        ExpYear = long.Parse(expYear),
                        Cvc = cvc,
                    },
                };

                var service = new PaymentMethodService();
                return await service.CreateAsync(options);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating payment method: {ex.Message}");
                throw;
            }
        }

        public async Task<bool> ProcessPaymentAsync(Order order, string cardNumber, string expMonth, string expYear, string cvc)
        {
            try
            {
                // Calculează totalul comenzii
                double totalAmount = order.Items.Sum(item => item.Price * item.Quantity);

                // Creează PaymentIntent
                var paymentIntent = await CreatePaymentIntentAsync(totalAmount);

                // Creează PaymentMethod
                var paymentMethod = await CreatePaymentMethodAsync(cardNumber, expMonth, expYear, cvc);

                // Confirmă plata
                var confirmedPayment = await ConfirmPaymentIntentAsync(paymentIntent.Id, paymentMethod.Id);

                return confirmedPayment.Status == "succeeded";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error processing payment: {ex.Message}");
                return false;
            }
        }

        public string GetPublishableKey()
        {
            return StripePublishableKey;
        }
    }
} 