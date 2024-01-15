# Pizzeria
**Главный экран для приложения доставки еды. Тестовое задание на позицию iOS Developer.**. 

## Техническое задание
* Реализовать главный экран для приложения доставки еды
* В баннеры можно захардкодить любые фото
* Основная задача - сделать идентичную планку с категориями и блок меню
* Планка с категориями при скролле должна прилипать к верхнему бару
* При нажатии на категорию, список должен пролистываться к соответствующему разделу
* В качестве API использовать любой открытый источник подходящий под текущие нужды
Опционально:
* Offline-режим: т.е. в случае, если нет доступа к сети, показывать последние загруженные данные.

## Ограничения на стек технологий
* Swift
* Clean Swift / VIPER / MVP
* UIKit
* Остальное на ваше усмотрение

Ссылка на макет figma: https://www.figma.com/file/QAV7uRlO2cI3lYjNOVIwmo/%D0%A2%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D0%BE%D0%B5-IOS-Copy?node-id=0%3A1

## Реализация

## Стэк, Ограничения и Архитектура
Стэк: **Swift 5, UIKit**
Минимальная версия: **iOS 15**   
Архитектура: **MVP**   

<table>
 <tr>
 <td align="center"><img src="https://i.imgur.com/USYQ6lt.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/V8uCDZb.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/J3pXrsF.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/bfTjIq0.png" width="350"></td>
 </tr>
</table>

## Video

https://github.com/YuryStep/Pizzeria/assets/112872920/885b6bcb-d437-4c97-9603-85313ba8af50

###### Примечания
* *В связи с ограничениями API, для снижения количества обращений к серверу загрузка данных из сети происходит только при первом открытии, а далее подгружается из памяти (логику можно изменить при необходимости)*
* Немного изменена (в сравнении с макетом) реализация кнопок выбора категорий меню. Вместо изменения фона у выбранных категорий - происходит анимация изменения рамера кнопки при нажатии.*

## Особенности проекта
* Проект написан на **`UIKit`** без использования сторонних фреймворков
* Использована архитектура **`MVP`**
* Верстка выполнена кодом **`без использования storyboard`**
* Используется **`UITableView + DataSource`** c кастомными ячейками
* Взаимодействие с сетью реализовано с использованием **`URLSession`**
* Работа с многопоточностью, с использованием **`GCD`**
* Кэширование изображений реализовано с использованием **`NSCache`**
* Сохранение позиций меню для раобты оффлайн происходит в **`UserDefaults`**
* Для обработки ошибок используется класс **`Result`**
* Использована **`кастомная UIButton`** c анимацией нажатия
* Цвета собраны в отдельном **`Asset Catalog`**
* Сборка вынесена в отдельный слой PizzeriaAssembly

## Что еще планируется реализовать технически
* В связи с ограниченными сроками на выполнение тестового задания код все еще требует дополнительный **рефакторинг**.
* Заменить способ работы с многопоточностью с GCD на **`Async await`**
* Заменить у таблицы DataSource на **DiffableDataSource**
* Добавить **CollectionView**
* Доработать **Layout** - шрифты, отступы
* Для сохранения чистоты кода добавить в проект  **`Swiftlint`** и **`SwiftFormat`**

## Другие PET проекты
* Более крупный (по функциональности и инструментам) проект для ознакомления доступен по ссылке: https://github.com/YuryStep/NewsCatcher

