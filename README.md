# DBMS-Fastag-open-ended-Project
## Problem Statement:
Implementation of database management for Fastag system that automatically stores Vehicle details, collects tolls from customer bank accounts and deposits in official toll plaza accounts.

## Entity Description:

Toll_plaza consists details of all the active plazas of the country. unique plaza code, plaza name, type, city, state. Fastag table classifies vehicles into unique colors.

Customers are connected to issuer banks and all toll plazas are associated to
different acquirer bank. Transactions takes place between these banks.

Bank_details contains IFSC, bank name and tells if it is issuer bank(customer bank) or
acquirer bank(associated with plaza).Assuming that bank can be either of them and
not both.

Plaza_details stores details of every plaza.plaza code referencing from Toll_plaza, color, toll for that color, number of vehicles of that color
passed, and IFSC code of plaza's bank(acquirer bank).

Issuer_bank(some banks among all the banks) stores customer details like name, unique account number, unique contact number, unique fastag_id issued by the bank, and bank balance. Assuming that bank separately displays balance of fastag toll of
the customers.

Vehicles are given VRN, model, chassis number, fastagid referencing in issuer_bank
relation, class(color). Assuming that a user owns only one vehicle.

Vehicle movement is tracked when it passes through a particular plaza. plaza_code, fastag id of the vehicle, time at which it passes is recoreded. Through fastag_id, the
bank balance is verified and status is updated. Bill gets generated. Acquirer bank holds its IFSC, account number for every plaza to which it is associated, plaza_code and account balance(total toll collected).

NETC mapper is taken as a view that connects to vehicle_movement, acquirer_bank
and issuer_bank. When vehicle passes through the plaza, the issuer bank account is verified. The
amount of is deducted from the issuer_ bank and added to the acquirer_bank. The
status is transaction is recorded in Transaction relation implimenting triggers.
