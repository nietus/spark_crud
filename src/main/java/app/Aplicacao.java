package app;

import static spark.Spark.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.StringReader;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import spark.Request;
import spark.Response;
import spark.Session;
import service.AppUserService;
import service.BuyersService;
import service.ProductsService;
import service.ProviderService;
import service.TransactionService;
import model.AppUsers;
import model.Buyers;
import model.Products;
import model.Provider;
import model.Transactions;

public class Aplicacao {

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static ProductsService productService = new ProductsService();
    private static AppUserService appUserService = new AppUserService();
    private static BuyersService buyerService = new BuyersService();
    private static ProviderService providerservice = new ProviderService();
    private static TransactionService transactionService = new TransactionService();
    
    private static String userEmail = null;
    
    static boolean isLoggedIn(Request request) {
        Session session = request.session(false);
        return (session != null && session.attribute("email") != null);
    }

    public static void main(String[] args) {
        port(5050);
        
        objectMapper.registerModule(new JavaTimeModule());
        staticFiles.externalLocation("src/main/resources/public");
        
        get("/check-session", (request, response) -> {
        	userEmail = request.session().attribute("email");
        	//System.out.println("Email: " + userEmail);
            if (!isLoggedIn(request)) {
                response.status(401);
            }
            return "";
        });

        post("/products/insert", (request, response) -> {
            try {
                String requestBody = request.body();
                System.out.println("Received JSON data: " + requestBody);
                JsonNode json = objectMapper.readTree(requestBody);

                String nome = json.get("nome").asText();
                int amount = json.get("amount").asInt();
                int min_amount = json.get("min_amount").asInt();
                String description = json.get("description").asText();
                double buyingPrice = json.get("buyingPrice").asDouble();
                double sellingPrice = json.get("sellingPrice").asDouble();
                LocalDateTime now = LocalDateTime.now();
                LocalDate date = now.toLocalDate();
                LocalDate vality = date;
                int userId = appUserService.getUserByEmail(userEmail).getId();
                int providerCNPJ = 123456789;
                String img_url = json.get("img_url").asText();

                productService.insertProduct(nome, amount, min_amount, description, buyingPrice, sellingPrice, vality, userId, providerCNPJ, img_url);

                response.status(201);
                return "Product inserted successfully!";
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (DateTimeParseException e) {
                response.status(400);
                return "Invalid date format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                return "Error: " + e.getMessage();
            }
        });

        post("/products/delete", (request, response) -> {
            int id = Integer.parseInt(request.queryParams("id"));
            productService.deleteProduct(id);
            response.status(200);
            return "Product deleted successfully!";
        });

        post("/products/update", (request, response) -> {
            int id = Integer.parseInt(request.queryParams("id"));
            String novoNome = request.queryParams("novo-nome");
            int novoAmount = Integer.parseInt(request.queryParams("novo-amount"));
            int novoMin_amount = Integer.parseInt(request.queryParams("novoMin-amount"));
            String novoDescription = request.queryParams("novo-description");
            double novoBuyingPrice = Double.parseDouble(request.queryParams("novo-buying_price"));
            double novoSellingPrice = Double.parseDouble(request.queryParams("novo-selling_price"));
            LocalDate novoVality = LocalDate.parse(request.queryParams("novo-vality"));
            int novoUserId = Integer.parseInt(request.queryParams("novo-user_id"));
            int novoProviderCNPJ = Integer.parseInt(request.queryParams("novo-provider_cnpj"));
            String img_url = request.queryParams("new-img_url");

            productService.updateProduct(id, novoNome, novoAmount, novoMin_amount, novoDescription, novoBuyingPrice, novoSellingPrice, novoVality, novoUserId, novoProviderCNPJ, img_url);
            response.status(200);
            return "Product updated successfully!";
        });
        
        get("/products/list", (request, response) -> {
            List<Products> productList = productService.getAllProducts(userEmail);

            StringBuilder html = new StringBuilder();
            for (Products product : productList) {
                html.append("<tr id=" + product.getId() + ">");
                html.append("<td><div>").append(product.getNome()).append("</div></td>");
                html.append("<td><div>").append(product.getId()).append("</div></td>");
                html.append("<td><div>").append(product.getSellingPrice()).append("</div></td>");
                html.append("<td id='amount"+product.getId()+"'><div>").append(product.getAmount()).append("</div></td>");
                html.append("</tr>");
            }

            return html.toString();
        });
        
        post("/appuser/insert", (request, response) -> {
            try {
                String requestBody = request.body();
                // System.out.println("Received JSON data: " + requestBody);
                JsonNode json = objectMapper.readTree(requestBody);

                String email = json.get("email").asText();
                String password = json.get("password").asText();
                int isPremium = 0;

                appUserService.insertAppUser(email, password, isPremium);

                response.status(201);
                return "AppUser inserted successfully!";
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                return "Error: " + e.getMessage();
            }
        });

        post("/products/deleteids", (request, response) -> {
            // Check if the request has a valid JSON object
            JsonObject requestData = JsonParser.parseReader(new StringReader(request.body())).getAsJsonObject();

            if (requestData.has("selectedRowIds")) {
                JsonArray idArray = requestData.getAsJsonArray("selectedRowIds");

                // Handle the array of IDs
                ArrayList<Integer> ids = new ArrayList<>();

                for (JsonElement idElement : idArray) {
                    if (idElement.isJsonPrimitive()) {
                        int id = idElement.getAsInt();
                        ids.add(id);
                    }
                }

                // Delete the products with the extracted IDs
                for (int id : ids) {
                    productService.deleteProduct(id);
                }

                response.status(200);
                return "Products deleted successfully!";
            } else {
                response.status(400); // Bad request
                return "Invalid JSON format in the request body.";
            }
        });



        
        post("/appuser/update", (request, response) -> {
            String email = request.queryParams("email");
            String newEmail = request.queryParams("new-email");
            String newPassword = request.queryParams("new-password");
            int newIsPremium = Integer.parseInt(request.queryParams("new-isPremium"));

            appUserService.updateAppUser(email, newEmail, newPassword, newIsPremium);
            response.status(200);
            return "AppUser updated successfully!";
        });
        
        post("/logout", (request, response) -> {
            Session session = request.session(false);
            if (session != null) {
                session.invalidate(); // Destroy the session
            }
            response.status(200);
            return "Logged out successfully";
        });

        
        get("/get-user-data", (request, response) -> {
            String email = userEmail;
            String password = appUserService.getAppUser(email).getPassword();

            // Create a JSON object with the data
            JsonObject userData = new JsonObject();
            userData.addProperty("email", email);
            userData.addProperty("password", password);

            response.type("application/json");
            return userData.toString();
        });


        
        get("/appuser/list", (request, response) -> {
            List<AppUsers> appUserList = appUserService.getAllAppUsers();

            StringBuilder html = new StringBuilder();
            for (AppUsers appUser : appUserList) {
                html.append("<tr ID=" + appUser.getId() + ">");
                html.append("<td><div>").append(appUser.getEmail()).append("</td>");
                html.append("<td><button class='btn btn-danger'>Delete</button></td>");
                html.append("<td><button class='btn btn-info'>Details</button></td>");
                html.append("</tr></div>");
            }

            return html.toString();
        });
        
        post("/buyer/insert", (request, response) -> {
            try {
                String requestBody = request.body();
                System.out.println("Received JSON data: " + requestBody);
                JsonNode json = objectMapper.readTree(requestBody);

                int cpf = json.get("cpf").asInt();
                String nome = json.get("nome").asText();
                String address = json.get("address").asText();
                String contactInfo = json.get("contact_info").asText();

                buyerService.insertBuyer(cpf, nome, address, contactInfo, appUserService.getUserByEmail(userEmail).getId());

                response.status(201);
                return "Buyer inserted successfully!";
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (DateTimeParseException e) {
                response.status(400);
                return "Invalid date format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                return "Error: " + e.getMessage();
            }
        });

        post("/buyer/delete", (request, response) -> {
            int cpf = Integer.parseInt(request.queryParams("cpf"));
            buyerService.deleteBuyer(cpf);
            response.status(200);
            return "Buyer deleted successfully!";
        });

        post("/buyer/update", (request, response) -> {
            int cpf = Integer.parseInt(request.queryParams("cpf"));
            String novoNome = request.queryParams("novo-nome");
            String novoAddress= request.queryParams("novo-address");
            String novoContactInfo = request.queryParams("novo-contact_info");

            buyerService.updateBuyer(cpf, novoNome, novoAddress, novoContactInfo, appUserService.getUserByEmail(userEmail).getId());
            response.status(200);
            return "Buyer updated successfully!";
        });
        
        get("/buyer/list", (request, response) -> {
            List<Buyers> buyerList = buyerService.getAllBuyers();

            StringBuilder html = new StringBuilder();
            for (Buyers buyer : buyerList) {
                html.append("<tr CPF=" + buyer.getCPF() + ">");
                html.append("<td><div>").append(buyer.getNome()).append("</div></td>");
                html.append("<td><div><button class='btn btn-danger'>Delete</button></div></td>");
                html.append("<td><div><button class='btn btn-info'>Details</button></div></td>");
                html.append("</tr>");
            }

            return html.toString();
        });
        
        post("/provider/insert", (request, response) -> {
            try {
                // Get the JSON data from the request body
                String requestBody = request.body();

                // Print the JSON data to the console
                System.out.println("Received JSON data: " + requestBody);

                // Parse JSON and process it
                JsonNode json = objectMapper.readTree(requestBody);

                int CNPJ = json.get("CNPJ").asInt();
                String nome = json.get("nome").asText();
                String contact_info = json.get("contact_info").asText();

                providerservice.insertProvider(CNPJ, nome, contact_info);

                response.status(201);
                return "Provider inserted successfully!";
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (DateTimeParseException e) {
                response.status(400);
                return "Invalid date format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                return "Error: " + e.getMessage();
            }
        });

        post("/provider/delete", (request, response) -> {
            int CNPJ = Integer.parseInt(request.queryParams("CNPJ"));
            providerservice.deleteProvider(CNPJ);
            response.status(200);
            return "Provider deleted successfully!";
        });

        post("/provider/update", (request, response) -> {
            int CNPJ = Integer.parseInt(request.queryParams("CNPJ"));
            String novoNome = request.queryParams("novo-nome");
            String novoContactInfo = request.queryParams("novo-contact_info");

            providerservice.updateProvider(CNPJ, novoNome, novoContactInfo);
            response.status(200);
            return "Provider updated successfully!";
        });

        get("/provider/list", (request, response) -> {
            List<Provider> providerList = providerservice.getAllProvider();

            StringBuilder html = new StringBuilder();
            for (Provider provider : providerList) {
                html.append("<tr>");
                html.append("<td><div>").append(provider.getCNPJ()).append("</div></td>");
                html.append("<td><div>").append(provider.getNome()).append("</div></td>");
                html.append("<td><div>").append(provider.getContactInfo()).append("</div></td>");
                html.append("</tr>");
            }

            return html.toString();
        });

        post("/login-endpoint", (request, response) -> {
            String requestBody = request.body();
            JsonNode json = objectMapper.readTree(requestBody);

            String email = json.get("email").asText();
            String password = json.get("password").asText();

            AppUsers user = appUserService.getUserByEmail(email);
            
            System.out.println(user.toString());

            if (user != null && user.getEmail().equals(email) && user.getPassword().equals(password)) {
                // Valid login
                request.session(true); // Create a new session
                request.session().attribute("email", email); // Store user in the session
                response.status(200);
                return "Login successful";
            } else {
                response.status(401);
                return "Login failed";
            }
        });
        
        post("/transactions/insert", (request, response) -> {
            try {
                String requestBody = request.body();
                System.out.println("Received JSON data: " + requestBody);
                JsonNode json = objectMapper.readTree(requestBody);

                LocalDate date = LocalDate.now();
                int buyerCpf = json.get("buyerCpf").asInt();
                int productId = json.get("productId").asInt();
                int amountSold = json.get("amountSold").asInt();
                Products product = productService.getProduct(productId);
                transactionService.insertTransaction(date, buyerCpf, productId, appUserService.getUserByEmail(userEmail).getId(), amountSold, product.getSellingPrice());
                response.status(201);
                return "Transaction inserted successfully!";
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (DateTimeParseException e) {
                response.status(400);
                return "Invalid date format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                System.out.println(e);
                return "Error: " + e.getMessage();
            }
        });

     // Get a list of all transactions
        get("/transactions/list", (request, response) -> {
        	int user_id = appUserService.getUserByEmail(userEmail).getId();
            List<Transactions> transactionList = transactionService.getAllTransactions(user_id);

            StringBuilder html = new StringBuilder();
            html.append("<html>");
            html.append("<head><title>Transaction List</title></head>");
            html.append("<body>");
            html.append("<h1>Transaction List</h1>");
            html.append("<table>");
            html.append("<tr><th>Date</th><th>Amount</th><th>Price</th></tr>");
            
            for (Transactions t : transactionList) {
                html.append("<tr>");
                html.append("<td>" + t.getDate() + "</td>");
                html.append("<td>" + t.getAmount_sold() + "</td>");
                html.append("<td>" + t.getPrice() + "</td>");
                html.append("</tr>");
            }

            html.append("</table>");
            html.append("</body>");
            html.append("</html>");

            return html.toString();
        });
        
        get("/transactions/plot/:id", (request, response) -> {
            int productId = Integer.parseInt(request.params(":id"));
            int user_id = appUserService.getUserByEmail(userEmail).getId();
            int isPremium = appUserService.getUserByEmail(userEmail).getIsPremium();
            
            System.out.println("Is user premium: " + isPremium);

            // Fetch transaction data for the specified product ID
            if(isPremium == 1) {
            	List<Transactions> transactionList = transactionService.getTransactionsByProductId(productId, user_id);
            	
            	// Convert the transaction list to JSON
            	String json = objectMapper.writeValueAsString(transactionList);
            	System.out.println(json);
            	
            	response.type("application/json");
            	response.status(200);
            	return json;
            }
            
            return "";
        });




        
        // Delete a transaction by ID
        delete("/transactions/delete/:id", (request, response) -> {
            int id = Integer.parseInt(request.params(":id"));
            transactionService.deleteTransaction(id);
            response.status(200);
            return "Transaction deleted successfully!";
        });
        
        put("/products/updateamount/:id", (request, response) -> {
            int id = Integer.parseInt(request.params(":id")); // Extract the product ID from the URL
            Products product = productService.getProduct(id);
            try {
                String requestBody = request.body();
                JsonNode json = objectMapper.readTree(requestBody);

                if (json.has("amount")) {
                    int removedAmount = json.get("amount").asInt();
                    productService.updateProduct(id, product.getNome(), product.getAmount() - removedAmount,product.getMin_amount(),product.getDescription(),product.getBuyingPrice(),product.getSellingPrice(),product.getVality(),product.getUserId(),product.getProviderCNPJ(),product.getImg());
                    response.status(200);
                    return "Product amount updated successfully";
                } else {
                    response.status(400);
                    return "Invalid request: 'amount' field missing in the request body.";
                }
            } catch (JsonParseException e) {
                response.status(400);
                return "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid number format: " + e.getMessage();
            } catch (Exception e) {
                response.status(500); // Internal Server Error
                return "Error updating product amount: " + e.getMessage();
            }
        });

        
        put("/products/update/:id", (request, response) -> {
            int id = Integer.parseInt(request.params(":id"));
            Products product = productService.getProduct(id);
            String errorMessage = "Product updated successfully";

            try {
                String requestBody = request.body();
                System.out.println("Received JSON data: " + requestBody);
                JsonNode json = objectMapper.readTree(requestBody);
                
                System.out.println(json.get("nome").asText());

                // Check if the fields are present before accessing them
                String nome = json.has("nome") ? json.get("nome").asText() : product.getNome();
                int amount = json.has("amount") ? json.get("amount").asInt() : product.getAmount();
                int min_amount = json.has("min_amount") ? json.get("min_amount").asInt() : product.getMin_amount();
                String description = json.has("description") ? json.get("description").asText() : product.getDescription();
                double buyingPrice = json.has("buyingPrice") ? json.get("buyingPrice").asDouble() : product.getBuyingPrice();
                double sellingPrice = json.has("sellingPrice") ? json.get("sellingPrice").asDouble() : product.getSellingPrice();
                LocalDate vality = LocalDate.now();
                int userId = appUserService.getUserByEmail(userEmail).getId();
                int providerCNPJ = json.has("providerCNPJ") ? json.get("providerCNPJ").asInt() : product.getProviderCNPJ();
                String img_url = json.has("img_url") ? json.get("img_url").asText() : product.getImg();

                productService.updateProduct(id, nome, amount, min_amount, description, buyingPrice, sellingPrice, vality, userId, providerCNPJ, img_url);
            } catch (JsonParseException e) {
                response.status(400);
                errorMessage = "Invalid JSON format: " + e.getMessage();
            } catch (NumberFormatException e) {
                response.status(400);
                errorMessage = "Invalid number format: " + e.getMessage();
            } catch (DateTimeParseException e) {
                response.status(400);
                errorMessage = "Invalid date format: " + e.getMessage();
            } catch (Exception e) {
                response.status(400);
                System.out.println(e);
                errorMessage = "Error: " + e.getMessage();
            }
            
            if (response.status() == 200) {
                errorMessage = "Product updated";
            }
            
            return errorMessage;
        });



        
        get("/products/:id", (request, response) -> {
            try {
                int productId = Integer.parseInt(request.params(":id"));
                System.out.println(productId);

                // Retrieve the product data based on the productId
                Products product = productService.getProduct(productId);

                if (product != null) {
                    response.status(200);
                    response.type("application/json");

                    // You can use your objectMapper to convert the product object to JSON
                    String productJson = objectMapper.writeValueAsString(product);
                    
                    System.out.println(productJson);

                    return productJson;
                } else {
                    response.status(404);
                    return "Product not found";
                }
            } catch (NumberFormatException e) {
                response.status(400);
                return "Invalid product ID format";
            } catch (Exception e) {
                response.status(500);
                System.out.println(e);
                return "Internal server error: " + e.getMessage();
            }
        });


    }
}