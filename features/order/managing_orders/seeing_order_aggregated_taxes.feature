@managing_orders
Feature: Seeing aggregated taxes of an order
    In order to be aware of taxes in an order
    As an Administrator
    I want to see aggregated taxes of a specific order

    Background:
        Given the store operates on a single channel in "France"
        And there is a zone "EU" containing all members of the European Union
        And default tax zone is "EU"
        And the store has "EU VAT" tax rate of 23% for "Standard EU services" within "EU" zone
        And the store has "EU Low VAT" tax rate of 10% for "Lowered EU services" within "EU" zone
        And the store has a product "Composite bow" priced at "€100.00"
        And it belongs to "Standard EU services" tax category
        And the store has a product "Claymore" priced at "€50.00"
        And it belongs to "Lowered EU services" tax category
        And the store has a product "Bastard sword" priced at "€150.00"
        And it belongs to "Lowered EU services" tax category
        And the store has "DHL" shipping method with "€10.00" fee within "EU" zone
        And shipping method "DHL" belongs to "Standard EU services" tax category
        And the store allows paying offline
        And there is a customer "charles.the.great@medieval.com" that placed an order "#00000001"
        And I am logged in as an administrator

    @ui
    Scenario: Seeing aggregated taxes of products and shipping
        Given the customer bought a single "Composite bow"
        And the customer chose "DHL" shipping method to "France" with "Offline" payment
        When I view the summary of the order "#00000001"
        Then there should be a shipping charge "DHL €10.00"
        And the order's shipping total should be "€12.30"
        And the order should have tax "EU VAT (23%) €25.30"
        And the order's tax total should be "€25.30"
        And the order's total should be "€135.30"

    @ui
    Scenario: Seeing aggregated taxes of multiple products from different tax rates and shipping
        Given the customer bought a single "Composite bow"
        And the customer bought a "Claymore" and a "Bastard sword"
        And the customer chose "DHL" shipping method to "France" with "Offline" payment
        When I view the summary of the order "#00000001"
        Then there should be a shipping charge "DHL €10.00"
        And the order's shipping total should be "€12.30"
        And the order should have tax "EU VAT (23%) €25.30"
        And the order should have tax "EU Low VAT (10%) €20.00"
        And the order's tax total should be "€45.30"
        And the order's total should be "€355.30"
