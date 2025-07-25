# 🛒 Acme Widget Co – Basket System

Acme Widget Co is the leading provider of made-up widgets. This repository is a proof of concept for their new sales system.

## 🧾 Project Overview

This system implements a shopping basket with support for:

- Product catalog management
- Dynamic delivery charges based on basket total
- Promotional offers using extensible strategy pattern
- Fully documented using [YARD](https://yardoc.org/)
- High test coverage using RSpec and SimpleCov

---

## ⚙️ Design Principles

This project demonstrates:

- ✅ **Good separation and encapsulation of concerns**
- ✅ **Small, accurate interfaces and classes**
- ✅ **Dependency injection of delivery and offer strategies**
- ✅ **Use of the strategy pattern for flexible rules**
- ✅ **100% test coverage with RSpec**
- ✅ **Clear, conventional commits**
- ✅ **YARD-based inline documentation**

---

## 📦 Product Catalog

| Product       | Code | Price  |
|---------------|------|--------|
| Red Widget    | R01  | $32.95 |
| Green Widget  | G01  | $24.95 |
| Blue Widget   | B01  | $7.95  |

---

## 🚚 Delivery Charges

- **<$50** → $4.95
- **$50 to <$90** → $2.95
- **$90 or more** → Free delivery

---

## 🏷️ Current Offers

- **Buy One Red Widget (R01), Get Second at Half Price**

---

## 📂 Project Structure

```
lib/
├── acme/
│   ├── basket.rb               # Basket logic
│   ├── product.rb              # Product entity
│   ├── product_catalog.rb      # Catalog lookup logic
│   └── strategies/
│       ├── delivery/
│       │   └── default.rb      # Delivery rule strategy
│       └── offers/
│           └── red_widget_half_price.rb  # Offer rule strategy

spec/
└── lib/
    └── acme/
        ├── basket_spec.rb
        ├── product_spec.rb
        ├── product_catalog_spec.rb
        ├── strategies/
            ├── delivery/
            │   └── default_spec.rb
            └── offers/
                └── red_widget_half_price_spec.rb
```

---

## 🧪 How to Run and Test

### 1. Install dependencies

```bash
bundle install
```

### 2. Run the test suite

```bash
bundle exec rspec
```

### 3. View coverage report

```bash
open coverage/index.html
```

### 4. Generate and view documentation

```bash
yard doc
open doc/index.html
```

### 5. Check code style

```bash
bundle exec rubocop
```

---

## 📊 Sample Baskets

| Basket Items               | Total   |
|---------------------------|---------|
| `B01, G01`                | $37.85  |
| `R01, R01`                | $54.37  |
| `R01, G01`                | $60.85  |
| `B01, B01, R01, R01, R01` | $98.27  |

---

## ✅ Assumptions

- Discounts apply before delivery calculation.
- Offers and delivery rules follow strategy pattern and are pluggable.
- Prices use `BigDecimal` for accuracy.
- Product codes are case-sensitive.

---

## 🧠 Technologies

- Ruby 3.1+
- RSpec
- SimpleCov
- RuboCop
- YARD for documentation

---

## 📤 Contributions

Feel free to fork and submit pull requests to extend this clean architecture or add new promotional/discount rules.

---

## 📄 License

MIT License.

## Made with ❤️ by [Hammad Khan](https://github.com/hammadxcm)

