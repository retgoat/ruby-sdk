Документация [здесь](https://weship.io/#docs "API docs")

# Инициализация

```ruby
w = WeshipClient.new('APIKEY1234567890')
```
В качестве параметра передаётся ключ API, который можно получить в личном кабинете: https://weship.io/#apikeys

# Валидация адресов
```ruby
#request
  address = {
    :line1=> "500 S BUENA VISTA ST",
    :city=> "BURBANK",
    :state=> "CA",
    :zip=> "91521",
    :country=> "US",
    :residential=> false,
    :name=> "DONALD DUCK",
    :company=> "DISNEY",
    :phone=> "1234567890",
}

w.validate_address(address)

#response
```

# Коробки
## Создание коробки

```ruby
#request
 package = {
     :title=>"My package", 
     :width=>3, 
     :length=>1, 
     :height=>3
     }

w.create_package(package)

# response

{"package"=>
  {"title"=>"My package",
   "id"=>3,
   "length"=>1,
   "width"=>3,
   "height"=>3,
   "dimension_units"=>"in"},
 "links"=>
  [{"rel"=>"self", "href"=>"http://stage.weship.io/api/v1/packages/3"}]}

```

## Редактирование коробки
```ruby
#request

 new_package = {
     :title=>"My another new package", 
     :width=>4, 
     :length=>2, 
     :height=>5
     }

w.update_package(1, new_package)

#response

{"package"=>
  {"title"=>"My new package",
   "id"=>3,
   "length"=>2,
   "width"=>4,
   "height"=>5,
   "dimension_units"=>"in"},
 "links"=>
  [{"rel"=>"self", "href"=>"http://stage.weship.io/api/v1/packages/3"}]}

```

## Получение спика коробок
```ruby
#request

w.get_packages_list()

#response

{"items"=>
  [{"title"=>"My new package",
    "id"=>3,
    "length"=>2,
    "width"=>4,
    "height"=>5,
    "dimension_units"=>"in",
    "links"=>
     [{"rel"=>"self", "href"=>"http://stage.weship.io/api/v1/packages/3"}]},
   {"title"=>"My another new package",
    "id"=>3,
    "length"=>2,
    "width"=>4,
    "height"=>5,
    "dimension_units"=>"in",
    "links"=>
     [{"rel"=>"self", "href"=>"http://stage.weship.io/api/v1/packages/4"}]}],
 "meta"=>{"count"=>2}}
```

## Получение одной коробки
```ruby
#request w.show_package(:id)
w.show_package(1)

#response
{"package"=>
  {"title"=>"My new package",
   "id"=>3,
   "length"=>2,
   "width"=>4,
   "height"=>5,
   "dimension_units"=>"in"},
 "links"=>
  [{"rel"=>"self", "href"=>"http://stage.weship.io/api/v1/packages/3"}]}

```

##Удаление коробки
```ruby
#request w.delete_package(:id)
w.delete_package(1)

#response
 => nil
```

При любом удалении ресурса сервер возвращает заголовок 204: no content

# Получение rates

```ruby
#request

rates = {
  :from_zip=> "77060",
  :to_zip=> "94040",
  :residential=> true,
  :packages=> [
    {
      :weight=>3,
      :length=>1,
      :width=>1,
      :height=>3
    }
  ]
}

w.get_rates(rates)

#response
[{"rate"=>12.89,
  "carrier"=>{"name"=>"FedEx", "service"=>"ground", "type"=>"WESHIP"},
  "delivery_days"=>3},
 {"rate"=>15.32,
  "carrier"=>{"name"=>"UPS", "service"=>"ground", "type"=>"OWN"},
  "delivery_days"=>4},
 {"rate"=>24.79,
  "carrier"=>{"name"=>"FedEx", "service"=>"3day", "type"=>"WESHIP"},
  "delivery_days"=>3},
 {"rate"=>28.95,
  "carrier"=>{"name"=>"UPS", "service"=>"3day", "type"=>"OWN"},
  "delivery_days"=>3},
 {"rate"=>34.87,
  "carrier"=>{"name"=>"FedEx", "service"=>"2day", "type"=>"WESHIP"},
  "delivery_days"=>2},
 {"rate"=>38.29,
  "carrier"=>{"name"=>"UPS", "service"=>"2day", "type"=>"OWN"},
  "delivery_days"=>2},
 {"rate"=>39.49,
  "carrier"=>{"name"=>"FedEx", "service"=>"2day_morning", "type"=>"WESHIP"},
  "delivery_days"=>2},
 {"rate"=>69.52,
  "carrier"=>{"name"=>"FedEx", "service"=>"1day", "type"=>"WESHIP"},
  "delivery_days"=>1},
 {"rate"=>72.87,
  "carrier"=>{"name"=>"UPS", "service"=>"1day", "type"=>"OWN"},
  "delivery_days"=>1},
 {"rate"=>76.68,
  "carrier"=>{"name"=>"FedEx", "service"=>"1day_morning", "type"=>"WESHIP"},
  "delivery_days"=>1},
 {"rate"=>80.5,
  "carrier"=>{"name"=>"UPS", "service"=>"1day_morning", "type"=>"OWN"},
  "delivery_days"=>1},
 {"rate"=>107.1,
  "carrier"=>
   {"name"=>"FedEx", "service"=>"1day_early_morning", "type"=>"WESHIP"},
  "delivery_days"=>1},
 {"rate"=>113.65,
  "carrier"=>{"name"=>"UPS", "service"=>"1day_early_morning", "type"=>"OWN"},
  "delivery_days"=>1}]

 ```
 В качестве коробки можно передать название уже созданной коробки:
 ```ruby
 #request
 rates_w_my_package = {
  :from_zip=> "77060",
  :to_zip=> "94040",
  :residential=> true,
  :packages=> [
    {
      :weight=>3,
      :length=>1,
      :width=>1,
      :height=>3
    },
    {
      :title=>"My package",
      :weight => 5
    }
  ]
}

w.get_rates(rates_w_my_package)

```
Ответ сервера будет аналогичным.

#Отправдения

## Создание отправдения
```ruby
#request

shipment = {
    :from=> {
      :line1=> "500 S BUENA VISTA ST",
      :city=> "BURBANK",
      :state=> "CA",
      :zip=> "91521",
      :country=> "US",
      :residential=> false,
      :name=> "DONALD DUCK",
      :company=> "DISNEY",
      :phone=> "1234567890"
    },
    :to=> {
        :line1=> "1515 E BUENA VISTA DR",
        :city=> "LAKE BUENA VISTA",
        :state=> "FL",
        :zip=> "32830",
        :country=> "US",
        :residential=> true,
        :name=> "Receiver name",
        :company=> "DISNEY CASTING CNTR",
        :phone=> "9876543210"
    },
    :package_type=> "box",
    :packages=>[
      {
        :length=>1,
        :width=>1,
        :height=>3,
        :weight=>3.1,
        :insured_value=> "1000"
      }
    ],
    :carrier=> {
      :name=> "FEDEX",
      :service=> "1day",
      :credentials=> "WESHIP"
    },
    :options=> {
      :signature_type=> "adult",
      :label_size=> "4X8",
      :label_type=> "pdf",
      :remarks=> "My test shipment",
      :saturday_delivery=> true
      }
    }
    
w.create_shipment(shipment)

#response
{"shipment"=>
  {"id"=>"2751F9E9DB904C738D54FFB59A3D6D70",
   "package_type"=>"box",
   "from"=>
    {"name"=>"DONALD DUCK",
     "company"=>"DISNEY",
     "email"=>nil,
     "phone"=>"1234567890",
     "line1"=>"500 S BUENA VISTA ST",
     "line2"=>nil,
     "city"=>"BURBANK",
     "state"=>"CA",
     "zip"=>"91521",
     "country"=>"US",
     "residential"=>false,
     "_meta"=>{"validated"=>false}},
   "to"=>
    {"name"=>"Receiver name",
     "company"=>"DISNEY CASTING CNTR",
     "email"=>nil,
     "phone"=>"9876543210",
     "line1"=>"1515 E BUENA VISTA DR",
     "line2"=>nil,
     "city"=>"LAKE BUENA VISTA",
     "state"=>"FL",
     "zip"=>"32830",
     "country"=>"US",
     "residential"=>true,
     "_meta"=>{"validated"=>false}},
   "options"=>
    {"signature_type"=>"adult",
     "remarks"=>"My test shipment",
     "saturday_delivery"=>true,
     "label_type"=>"pdf"},
   "packages"=>
    [{"title"=>"CUSTOM",
      "length"=>1.0,
      "width"=>1.0,
      "height"=>3.0,
      "dimension_units"=>"in",
      "weight"=>3.1,
      "weight_units"=>"lb",
      "insured_value"=>1000.0,
      "_meta"=>{"insurance_amount"=>8.35}}],
   "carrier"=>{"name"=>"FEDEX", "service"=>"1day", "credentials"=>"WESHIP"},
   "_meta"=>
    {"status"=>"not_requested",
     "tracking_status"=>{"code"=>"not_tendered", "name"=>"Not tendered"},
     "total_insured_value"=>1000.0,
     "total_insurance_amount"=>8.35,
     "cancellable"=>false,
     "created_at"=>{"datetime"=>"12/16/2013 10:09", "date"=>"12/16/2013"}}},
 "links"=>
  [{"rel"=>"self",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70"},
   {"rel"=>"rates",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/rates"},
   {"rel"=>"track",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/track"}]}
```

## Редактирование отправления
```ruby
#request w.update_shipment(:id, params)
shipment_params =   {
    :carrier=> {
      :name=> "UPS",
      :service=> "ground",
      :credentials=> "WESHIP"
    },
    :options=> {
      :signature_type=> "adult",
      :label_size=> "4X6",
      :label_type=> "pdf",
      :remarks=> "My test shipment",
      :saturday_delivery=> true
    }
  }
  
w.update_shipment('2751F9E9DB904C738D54FFB59A3D6D70',shipment_params)

#response
{"shipment"=>
  {"id"=>"2751F9E9DB904C738D54FFB59A3D6D70",
   "package_type"=>"box",
   "from"=>
    {"name"=>"DONALD DUCK",
     "company"=>"DISNEY",
     "email"=>nil,
     "phone"=>"1234567890",
     "line1"=>"500 S BUENA VISTA ST",
     "line2"=>nil,
     "city"=>"BURBANK",
     "state"=>"CA",
     "zip"=>"91521",
     "country"=>"US",
     "residential"=>false,
     "_meta"=>{"validated"=>false}},
   "to"=>
    {"name"=>"Receiver name",
     "company"=>"DISNEY CASTING CNTR",
     "email"=>nil,
     "phone"=>"9876543210",
     "line1"=>"1515 E BUENA VISTA DR",
     "line2"=>nil,
     "city"=>"LAKE BUENA VISTA",
     "state"=>"FL",
     "zip"=>"32830",
     "country"=>"US",
     "residential"=>true,
     "_meta"=>{"validated"=>false}},
   "options"=>
    {"signature_type"=>"adult",
     "remarks"=>"My test shipment",
     "saturday_delivery"=>true,
     "label_type"=>"pdf"},
   "packages"=>
    [{"title"=>"CUSTOM",
      "length"=>1.0,
      "width"=>1.0,
      "height"=>3.0,
      "dimension_units"=>"in",
      "weight"=>3.1,
      "weight_units"=>"lb",
      "insured_value"=>1000.0,
      "_meta"=>{"insurance_amount"=>8.35}}],
   "carrier"=>{"name"=>"UPS", "service"=>"ground", "credentials"=>"WESHIP"},
   "_meta"=>
    {"total_signature_amount"=>4.5,
     "status"=>"not_requested",
     "tracking_status"=>{"code"=>"not_tendered", "name"=>"Not tendered"},
     "total_insured_value"=>1000.0,
     "total_insurance_amount"=>8.35,
     "cancellable"=>false,
     "created_at"=>{"datetime"=>"12/16/2013 10:09", "date"=>"12/16/2013"}}},
 "links"=>
  [{"rel"=>"self",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70"},
   {"rel"=>"rates",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/rates"},
   {"rel"=>"track",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/track"}]}
```

## Получение списка отправлений
```ruby
#request
w.get_shipments_list()

#response
{"items"=>
  [{"id"=>"2751F9E9DB904C738D54FFB59A3D6D70",
    "package_type"=>"box",
    "from"=>
     {"name"=>"DONALD DUCK",
      "company"=>"DISNEY",
      "email"=>nil,
      "phone"=>"1234567890",
      "line1"=>"500 S BUENA VISTA ST",
      "line2"=>nil,
      "city"=>"BURBANK",
      "state"=>"CA",
      "zip"=>"91521",
      "country"=>"US",
      "residential"=>false,
      "_meta"=>{"validated"=>false}},
    "to"=>
     {"name"=>"Receiver name",
      "company"=>"DISNEY CASTING CNTR",
      "email"=>nil,
      "phone"=>"9876543210",
      "line1"=>"1515 E BUENA VISTA DR",
      "line2"=>nil,
      "city"=>"LAKE BUENA VISTA",
      "state"=>"FL",
      "zip"=>"32830",
      "country"=>"US",
      "residential"=>true,
      "_meta"=>{"validated"=>false}},
    "options"=>
     {"signature_type"=>"adult",
      "remarks"=>"My test shipment",
      "saturday_delivery"=>true,
      "label_type"=>"pdf"},
    "packages"=>
     [{"title"=>"CUSTOM",
       "length"=>1.0,
       "width"=>1.0,
       "height"=>3.0,
       "dimension_units"=>"in",
       "weight"=>3.1,
       "weight_units"=>"lb",
       "insured_value"=>1000.0,
       "_meta"=>{"insurance_amount"=>8.35}}],
    "carrier"=>{"name"=>"UPS", "service"=>"ground", "credentials"=>"WESHIP"},
    "_meta"=>
     {"total_signature_amount"=>4.5,
      "status"=>"not_requested",
      "tracking_status"=>{"code"=>"not_tendered", "name"=>"Not tendered"},
      "total_insured_value"=>1000.0,
      "total_insurance_amount"=>8.35,
      "cancellable"=>false,
      "created_at"=>{"datetime"=>"12/16/2013 10:09", "date"=>"12/16/2013"}},
    "links"=>
     [{"rel"=>"self",
       "href"=>
        "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70"},
      {"rel"=>"rates",
       "href"=>
        "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/rates"},
      {"rel"=>"track",
       "href"=>
        "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/track"}]},
   ,
   ...
 "meta"=>{"count"=>8}}
 ```
 ## Получение одного отправления
 ```ruby
#request w.get_shipment(:id)
w.get_shipment('2751F9E9DB904C738D54FFB59A3D6D70')

#response
{"shipment"=>
  {"id"=>"2751F9E9DB904C738D54FFB59A3D6D70",
   "package_type"=>"box",
   "from"=>
    {"name"=>"DONALD DUCK",
     "company"=>"DISNEY",
     "email"=>nil,
     "phone"=>"1234567890",
     "line1"=>"500 S BUENA VISTA ST",
     "line2"=>nil,
     "city"=>"BURBANK",
     "state"=>"CA",
     "zip"=>"91521",
     "country"=>"US",
     "residential"=>false,
     "_meta"=>{"validated"=>false}},
   "to"=>
    {"name"=>"Receiver name",
     "company"=>"DISNEY CASTING CNTR",
     "email"=>nil,
     "phone"=>"9876543210",
     "line1"=>"1515 E BUENA VISTA DR",
     "line2"=>nil,
     "city"=>"LAKE BUENA VISTA",
     "state"=>"FL",
     "zip"=>"32830",
     "country"=>"US",
     "residential"=>true,
     "_meta"=>{"validated"=>false}},
   "options"=>
    {"signature_type"=>"adult",
     "remarks"=>"My test shipment",
     "saturday_delivery"=>true,
     "label_type"=>"pdf"},
   "packages"=>
    [{"title"=>"CUSTOM",
      "length"=>1.0,
      "width"=>1.0,
      "height"=>3.0,
      "dimension_units"=>"in",
      "weight"=>3.1,
      "weight_units"=>"lb",
      "insured_value"=>1000.0,
      "_meta"=>{"insurance_amount"=>8.35}}],
   "carrier"=>{"name"=>"UPS", "service"=>"ground", "credentials"=>"WESHIP"},
   "_meta"=>
    {"total_signature_amount"=>4.5,
     "status"=>"not_requested",
     "tracking_status"=>{"code"=>"not_tendered", "name"=>"Not tendered"},
     "total_insured_value"=>1000.0,
     "total_insurance_amount"=>8.35,
     "cancellable"=>false,
     "created_at"=>{"datetime"=>"12/16/2013 10:09", "date"=>"12/16/2013"}}},
 "links"=>
  [{"rel"=>"self",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70"},
   {"rel"=>"rates",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/rates"},
   {"rel"=>"track",
    "href"=>
     "http://stage.weship.io/api/v1/shipments/2751F9E9DB904C738D54FFB59A3D6D70/track"}]}
```
## Получение тарифов для одного шипмента
```ruby
#request w.get_shipment_rates(:id)
w.get_shipment_rates('2751F9E9DB904C738D54FFB59A3D6D70')

#response
{"items"=>
  [{"rate"=>27.49,
    "carrier"=>{"name"=>"FedEx", "service"=>"ground", "type"=>"WESHIP"},
    "delivery_days"=>4},
   {"rate"=>30.56,
    "carrier"=>{"name"=>"UPS", "service"=>"ground", "type"=>"OWN"},
    "delivery_days"=>4},
   {"rate"=>45.23,
    "carrier"=>{"name"=>"FedEx", "service"=>"3day", "type"=>"WESHIP"},
    "delivery_days"=>3},
   {"rate"=>47.66,
    "carrier"=>{"name"=>"UPS", "service"=>"3day", "type"=>"OWN"},
    "delivery_days"=>3},
   {"rate"=>53.56,
    "carrier"=>{"name"=>"FedEx", "service"=>"2day", "type"=>"WESHIP"},
    "delivery_days"=>2},
   {"rate"=>57.33,
    "carrier"=>{"name"=>"UPS", "service"=>"2day", "type"=>"OWN"},
    "delivery_days"=>2},
   {"rate"=>59.0,
    "carrier"=>{"name"=>"FedEx", "service"=>"2day_morning", "type"=>"WESHIP"},
    "delivery_days"=>2},
   {"rate"=>94.9,
    "carrier"=>{"name"=>"UPS", "service"=>"1day", "type"=>"OWN"},
    "delivery_days"=>1},
   {"rate"=>99.48,
    "carrier"=>{"name"=>"FedEx", "service"=>"1day_morning", "type"=>"WESHIP"},
    "delivery_days"=>1},
   {"rate"=>103.46,
    "carrier"=>{"name"=>"UPS", "service"=>"1day_morning", "type"=>"OWN"},
    "delivery_days"=>1},
   {"rate"=>129.9,
    "carrier"=>
     {"name"=>"FedEx", "service"=>"1day_early_morning", "type"=>"WESHIP"},
    "delivery_days"=>1},
   {"rate"=>136.61,
    "carrier"=>{"name"=>"UPS", "service"=>"1day_early_morning", "type"=>"OWN"},
    "delivery_days"=>1}],
 "meta"=>{"count"=>12}}
```

## Покупка отправления
```ruby
#request w.buy_shipment(:id)

w.buy_shipment('E10C9D74F9AC4359B8AC2920BEE99448')

#response
{:labels=>
  [{:tracking_number=>"794827603007",
    :label_file=>
     "https://stage.weship.io/api/v1/packages/518FF3154AB149F8AE41AF1B15A5C79F/label"},
   {:tracking_number=>"794827603040",
    :label_file=>
     "https://stage.weship.io/api/v1/packages/8215AEB4C67C4C0D8C197C48CDEF5883/label"}]}
```

## Быстрая покупка отправления
```ruby
#request
shipment = {:from=>
  {:line1=>"500 S BUENA VISTA ST",
   :city=>"BURBANK",
   :state=>"CA",
   :zip=>"91521",
   :country=>"US",
   :residential=>false,
   :name=>"DONALD DUCK",
   :company=>"DISNEY",
   :phone=>"1234567890"},
 :to=>
  {:line1=>"1515 E BUENA VISTA DR",
   :city=>"LAKE BUENA VISTA",
   :state=>"FL",
   :zip=>"32830",
   :country=>"US",
   :residential=>true,
   :name=>"Receiver name",
   :company=>"DISNEY CASTING CNTR",
   :phone=>"9876543210"},
 :package_type=>"box",
 :packages=>
  [{:length=>1, :width=>1, :height=>3, :weight=>3.1, :insured_value=>"1000"}],
 :carrier=>{:name=>"UPS", :service=>"1day", :credentials=>"WESHIP"},
 :options=>{:remarks=>"My test shipment"}}

w.purchase_shipment(shipment)

#response
{"labels"=>
  [{"tracking_number"=>"1Z426F0W1393884237",
    "label_file"=>
     "http://stage.weship.io/api/v1/packages/2495D7F779C544C798B68C73F8AED4CE/label"}]}
 => {"labels"=>[{"tracking_number"=>"1Z426F0W1393884237", "label_file"=>"http://stage.weship.io/api/v1/packages/2495D7F779C544C798B68C73F8AED4CE/label"}]} 
```
## Отслеживание отправления
```ruby
#request
track = {
  :carrier=> "FEDEX",
  :tracking_number=> "440719515003652"
}

w.track_shipment(track)

#response
{"tracking"=>
  {"ed_time"=>nil,
   "status"=>"not_tendered",
   "carrier"=>"FEDEX",
   "tracking_history"=>[]}}
```
