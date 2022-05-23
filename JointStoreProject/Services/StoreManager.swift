//
//  StoreManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 13.05.2022.
//

class StoreManager {
     static let shared = StoreManager()

     let products = [
        Product(name: "Помидоры розовые",
                description: "Помидоры имеют превосходные вкусовые качества и аромат. Мякоть у плодов данного сорта отличается особенной нежностью и сладковатым вкусом",
                price: 120,
                unit: .weight),
        Product(name: "Огурцы",
                description: "Огурцы часто используются для приготовления салатов, супов, закусок, смузи, а также прекрасно подходят для зимних заготовок благодаря своему небольшому размеру.",
                price: 90,
                unit: .weight),
        Product(name: "Перец красный",
                description: "Сочный овощ ярко-красного цвета с мясистой, хрустящей мякотью. Отличается сладким вкусом и свежим ароматом.",
                price: 200,
                unit: .weight),
        Product(name: "Картофель",
                description: "Картофель отличается ровными, слегка продолговатыми клубнями и тонкой кожурой. Молодой картофель подходит для различных кулинарных экспериментов.",
                price: 60,
                unit: .weight),
        Product(name: "Редис",
                description: "Редис – сочный, хрустящий корнеплод с пикантным вкусом. Редис благоприятно влияет на здоровье человека.",
                price: 140,
                unit: .weight),
        Product(name: "Кабачки",
                description: "Этот универсальный продукт широко используется в традиционном, вегетарианском, детском и диетическом питании.",
                price: 200,
                unit: .weight),
        Product(name: "Баклажаны",
                description: "Баклажан имеет отличительный синий цвет, а сам плод имеет вытянутую овальную форму",
                price: 210,
                unit: .weight),
        Product(name: "Морковь",
                description: "Морковь отличается ярким сладким вкусом и приятным свежим ароматом.",
                price: 60,
                unit: .weight),
        Product(name: "Капуста",
                description: "Овощ — кладезь витаминов С, А, В1 и В2, Р, К, а также клетчатки и микроэлементов.",
                price: 120,
                unit: .weight),
        Product(name: "Свекла",
                description: "Свекла – корнеплод, обладающий сочной, плотной структурой, ярким цветом и сладким вкусом.",
                price: 130,
                unit: .weight),
        Product(name: "Брокколи",
                description: "Брокколи – очень полезный и диетический овощ. Наиболее он полезен, в сыром и вареном видах.",
                price: 400,
                unit: .weight),
        Product(name: "Грибы Шампиньоны",
                description: "Этот популярный сорт грибов можно купить в любое время года. Шампиньоны имеют плотную ножку и округлую шляпку.",
                price: 500,
                unit: .weight),
        Product(name: "Имбирь",
                description: "Продукт является одной из самых распространенных пряностей в мировой кулинарии, используется для приготовления настоев, чаев.",
                price: 700,
                unit: .weight),
        Product(name: "Свекла",
                description: "Свекла – корнеплод, обладающий сочной, плотной структурой, ярким цветом и сладким вкусом.",
                price: 120,
                unit: .weight)
     ]

     private init() {}
    
    /// Поиск товара из доступных по полному/частичному названию
    func searchProducts(by search: String) -> [Product] {
        let trimmed = search.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return products.filter { $0.name.lowercased().contains(trimmed.lowercased()) }
    }
}
