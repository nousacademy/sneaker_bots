#!/usr/bin/bash

# pid is on url after _ is the size number
pid='S79864_630'
# master pid everything before underscore
masterPid='S79864'
#  quantity
qty='1'

firstName='YOUR NAME'
lastName='YOUR LAST NAME'
address1='YOUR ADDRESS'
apt='YOUR APT'
city='YOUR CITY'
state='YOUR STATE'
country='YOUR COUNTRY'
zipcode='YOUR ZIPCODE'
phone='YOUR NUMBER'
email='YOUR EMAIL'
ccnumber='YOUR CC NUMBER'
ccyear='YOUR CC YEAR'
cc3digit='YOUR CC 3 DIGIT'
ccmonth='YOUR CC MONTH'

# test url: 
# http://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/Cart-MiniAddProduct?layer=Add%20To%20Bag%20overlay&pid=S74927_530&Quantity=1&masterPid=S74927&ajax=true

# backdoor
# http://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/Cart-MiniAddProduct?layer=Add%20To%20Bag%20overlay&pid=BY2456&Quantity=1&masterPid=BY2456_710&ajax=true
# http://www.adidas.com/us/yeezy-boost-750/BY2456.html 251286
curl -v -L "http://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/Cart-MiniAddProduct?layer=Add%20To%20Bag%20overlay&pid=$pid&Quantity=$qty&masterPid=$masterPid&ajax=true" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H "Referer: https://www.adidas.com/us/delivery-start?pid_1=$masterPid&qty_1=1&basketKey=" -c cookies.txt -H 'Connection: keep-alive' --compressed --output adidas.html

curl 'https://www.adidas.com/us/checkout-start' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' --cookie cookies.txt --cookie-jar cookies.txt -H 'Connection: keep-alive' --compressed 

curl 'https://www.adidas.com/us/delivery-start' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: https://www.adidas.com/us/checkout-start' --cookie cookies.txt --cookie-jar cookies.txt -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' --compressed --output adidas.html

submitShippingURL=$(cat adidas.html | grep -m 1 'dwcont' | cut -f4 -d\")
deliverySecureKey=$(cat adidas.html | grep -m 1 'dwfrm_delivery_securekey' | cut -f6 -d\")

echo $submitShippingURL' here is url'
echo $deliverySecureKey

curl -v $submitShippingURL --cookie cookies.txt --cookie-jar cookies.txt -H 'Origin: https://www.adidas.com' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: text/html, */*; q=0.01' -H 'Referer: https://www.adidas.com/us/delivery-start' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data "dwfrm_delivery_shippingOriginalAddress=false&dwfrm_delivery_shippingSuggestedAddress=false&dwfrm_delivery_singleshipping_shippingAddress_isedited=false&dwfrm_delivery_singleshipping_shippingAddress_addressFields_firstName=$firstName&dwfrm_delivery_singleshipping_shippingAddress_addressFields_lastName=$lastName&dwfrm_delivery_singleshipping_shippingAddress_addressFields_address1=$address1&dwfrm_delivery_singleshipping_shippingAddress_addressFields_address2=$apt&dwfrm_delivery_singleshipping_shippingAddress_addressFields_city=$city&dwfrm_delivery_singleshipping_shippingAddress_addressFields_countyProvince=$state&state=&dwfrm_delivery_singleshipping_shippingAddress_addressFields_zip=$zipcode&dwfrm_delivery_singleshipping_shippingAddress_addressFields_phone=$phone&dwfrm_delivery_singleshipping_shippingAddress_useAsBillingAddress=true&dwfrm_delivery_securekey=$deliverySecureKey&dwfrm_delivery_billingOriginalAddress=false&dwfrm_delivery_billingSuggestedAddress=false&dwfrm_delivery_billing_billingAddress_isedited=false&dwfrm_delivery_billing_billingAddress_addressFields_country=$country&dwfrm_delivery_billing_billingAddress_addressFields_firstName=$firstName&dwfrm_delivery_billing_billingAddress_addressFields_lastName=$lastName&dwfrm_delivery_billing_billingAddress_addressFields_address1=$address1&dwfrm_delivery_billing_billingAddress_addressFields_address2=$apt&dwfrm_delivery_billing_billingAddress_addressFields_city=$city&dwfrm_delivery_billing_billingAddress_addressFields_countyProvince=$state&state=&dwfrm_delivery_billing_billingAddress_addressFields_zip=$zipcode&dwfrm_delivery_billing_billingAddress_addressFields_phone=$phone&dwfrm_delivery_singleshipping_shippingAddress_email_emailAddress=$email&signup_source=shipping&dwfrm_delivery_singleshipping_shippingAddress_ageConfirmation=true&dwfrm_delivery_singleshipping_shippingAddress_agreeForSubscription=true&shipping-group-0=Preorder&dwfrm_cart_shippingMethodID_0=Preorder&shippingMethodType_0=inline&dwfrm_cart_selectShippingMethod=ShippingMethodID&referer=Cart-Show&dwfrm_delivery_savedelivery=Review%20and%20Pay&format=ajax" --compressed 

curl 'https://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/COSummary-Start' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'  -H 'Referer: https://www.adidas.com/us/delivery-start' --cookie cookies.txt --cookie-jar cookies.txt -H 'Connection: keep-alive' --compressed --output adidas.html

paymentSecureKey=$(cat adidas.html | grep -m 1 'dwfrm_payment_securekey' | cut -f6 -d\")
submitCCurl=$(cat adidas.html | grep -m 1 'signDataURL' | cut -f4 -d\")

# submit cc info 

curl $submitCCurl --cookie cookies.txt --cookie-jar cookies.txt -H 'Origin: https://www.adidas.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/COSummary-Start' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data "dwfrm_payment_creditCard_type=001&dwfrm_payment_creditCard_owner=$firstName+$lastName&dwfrm_payment_creditCard_number=$ccnumber&dwfrm_payment_creditCard_month=$ccmonth&dwfrm_payment_creditCard_year=$ccyear&dwfrm_payment_creditCard_cvn=$cc3digit&dwfrm_payment_securekey=$paymentSecureKey&dwfrm_payment_signcreditcardfields=sign" --compressed --output cc.txt

# send cc info to get authenticated

access_key=$(cat cc.json | python -mjson.tool | grep -m 1 'access_key' | cut -f4 -d\")
amount=$(cat cc.json | python -mjson.tool | grep -m 1 'amount' | cut -f4 -d\")
ccexpdate=$(cat cc.json | python -mjson.tool | grep -m 1 'card_expiry_date' | cut -f4 -d\")
profile_id=$(cat cc.json | python -mjson.tool | grep -m 1 'profile_id' | cut -f4 -d\")
reference_number=$(cat cc.json | python -mjson.tool | grep -m 1 'reference_number' | cut -f4 -d\")
signed_date_time=$(cat cc.json | python -mjson.tool | grep -m 1 'signed_date_time' | cut -f4 -d\")
transaction_uuid=$(cat cc.json | python -mjson.tool | grep -m 1 'transaction_uuid"' | cut -f4 -d\")
device_fingerprint_id=$(cat cc.json | python -mjson.tool | grep -m 1 'device_fingerprint_id' | cut -f4 -d\")
customer_ip_address=$(cat cc.json | python -mjson.tool | grep -m 1 'customer_ip_address' | cut -f4 -d\")
merchant_defined_data1=$(cat cc.json | python -mjson.tool | grep -m 1 'merchant_defined_data1' | cut -f4 -d\")
merchant_defined_data2=$(cat cc.json | python -mjson.tool | grep -m 1 'merchant_defined_data2' | cut -f4 -d\")
merchant_defined_data4=$(cat cc.json | python -mjson.tool | grep -m 1 'merchant_defined_data4' | cut -f4 -d\")
merchant_defined_data6=$(cat cc.json | python -mjson.tool | grep -m 1 'merchant_defined_data6' | cut -f4 -d\")
merchant_defined_data7=$(cat cc.json | python -mjson.tool | grep -m 1 'merchant_defined_data7' | cut -f4 -d\")
unsigned_field_names=$(cat cc.json | python -mjson.tool | grep -m 1 'unsigned_field_names"' | cut -f4 -d\")
transaction_type=$(cat cc.json | python -mjson.tool | grep -m 1 'transaction_type"' | cut -f4 -d\")
item_0_unit_price=$(cat cc.json | python -mjson.tool | grep -m 1 'item_0_unit_price' | cut -f4 -d\")
item_0_code=$(cat cc.json | python -mjson.tool | grep -m 1 'item_0_code' | cut -f4 -d\")
item_0_name=$(cat cc.json | python -mjson.tool | grep -m 1 'item_0_name' | cut -f4 -d\")
item_0_tax_amount=$(cat cc.json | python -mjson.tool | grep -m 1 'item_0_tax_amount' | cut -f4 -d\")
item_1_unit_price=$(cat cc.json | python -mjson.tool | grep -m 1 'item_1_unit_price' | cut -f4 -d\")

# line_item_count=$(cat cc.json | python -mjson.tool | grep -m 1 'line_item_count' | cut -f4 -d\")
tax_amount=$(cat cc.json | python -mjson.tool | grep -m 1 '"tax_amount"' | cut -f4 -d\")
item_1_tax_amount=$(cat cc.json | python -mjson.tool | grep -m 1 'item_1_tax_amount' | cut -f4 -d\")
item_1_sku=$(cat cc.json | python -mjson.tool | grep -m 1 'item_1_sku' | cut -f4 -d\")
item_1_name=$(cat cc.json | python -mjson.tool | grep -m 1 'item_1_name' | cut -f4 -d\")
item_1_code=$(cat cc.json | python -mjson.tool | grep -m 1 'item_1_code' | cut -f4 -d\")
signed_field_names=$(cat cc.json | python -mjson.tool | grep -m 1 'signed_field_names' | cut -f4 -d\")
signature=$(cat cc.json | python -mjson.tool | grep -m 1 'signature' | cut -f4 -d\")

curl 'https://secureacceptance.cybersource.com/silent/pay' -H 'Origin: https://www.adidas.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://www.adidas.com/on/demandware.store/Sites-adidas-US-Site/en_US/COSummary-Start' -H 'Connection: keep-alive' --data "access_key=$access_key&amount=$amount&bill_to_address_city=$city&bill_to_address_country=$country&bill_to_address_line1=$address1&bill_to_email=$email&bill_to_forename=$firstName&bill_to_surname=$lastName&card_expiry_date=$ccexpdate&card_type=001&currency=USD&locale=en-us&payment_method=card&profile_id=$profile_id&reference_number=$reference_number&signed_date_time=$signed_date_time&transaction_uuid=$transaction_uuid&transaction_type=$transaction_type&unsigned_field_names=$unsigned_field_names&override_custom_receipt_page=$submitCCurl&bill_to_phone=$phone&bill_to_address_state=$state&bill_to_address_postal_code=$zipcode&device_fingerprint_id=$device_fingerprint_id&customer_ip_address=$customer_ip_address&merchant_defined_data1=$merchant_defined_data1&merchant_defined_data2=$merchant_defined_data2&merchant_defined_data4=$merchant_defined_data4&merchant_defined_data6=$merchant_defined_data6&merchant_defined_data7=$merchant_defined_data7&ship_to_address_city=$city&ship_to_address_country=$country&ship_to_address_line1=$address1&ship_to_address_postal_code=$zipcode&ship_to_address_state=$state&ship_to_forename=$firstName&ship_to_phone=$phone&ship_to_surname=$lastName&item_0_quantity=$qty&item_0_unit_price=$item_0_unit_price&item_0_code=$item_0_code&item_0_name=$item_0_name&item_0_sku=$masterPid&item_0_tax_amount=$item_0_tax_amount&item_1_quantity=$qty&item_1_unit_price=$item_1_unit_price&item_1_code=$item_1_code&item_1_name=$item_1_name&item_1_sku=$item_1_sku&item_1_tax_amount=$item_1_tax_amount&tax_amount=$tax_amount&line_item_count=2&signed_field_names=$signed_field_names&signature=$signature&card_cvn=$cc3digit&card_number=$ccnumber" --compressed


