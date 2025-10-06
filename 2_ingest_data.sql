se database dash_db_si;
use schema hotel;
use warehouse dash_wh_si;

-- ingest sample data 
create or replace table amenity
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/amenity.csv',
          file_format=>'csv_format'
        )
    )
);

copy into amenity
from @files_stage/amenity.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- guest
copy files
into @files_stage
from @datasets/branches/main/guest.csv;

create or replace table guest
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/guest.csv',
          file_format=>'csv_format'
        )
    )
);

copy into guest
from @files_stage/guest.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- hotel
copy files
into @files_stage
from @datasets/branches/main/hotel.csv;
create or replace table hotel
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/hotel.csv',
          file_format=>'csv_format'
        )
    )
);

copy into hotel
from @files_stage/hotel.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- invoice
copy files
into @files_stage
from @datasets/branches/main/invoice.csv;
create or replace table invoice
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/invoice.csv',
          file_format=>'csv_format'
        )
    )
);  
copy into invoice
from @files_stage/invoice.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- payment
copy files
into @files_stage
from @datasets/branches/main/payment.csv;
create or replace table payment
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/payment.csv',
          file_format=>'csv_format'
        )
    )
);
copy into payment
from @files_stage/payment.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- reservation  
copy files
into @files_stage
from @datasets/branches/main/reservation.csv;

create or replace table reservation
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/reservation.csv',
          file_format=>'csv_format'
        )
    )
);  
copy into reservation
from @files_stage/reservation.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- reservation_amenity
copy files
into @files_stage
from @datasets/branches/main/reservation_amenity.csv;
create or replace table reservation_amenity
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/reservation_amenity.csv',
          file_format=>'csv_format'
        )
    )
);
copy into reservation_amenity
from @files_stage/reservation_amenity.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- room
copy files
into @files_stage
from @datasets/branches/main/room.csv;
create or replace table room
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/room.csv',
          file_format=>'csv_format'
        )
    )
);

copy into room
from @files_stage/room.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- room_monthly_aggregate
copy files
into @files_stage
from @datasets/branches/main/room_monthly_aggregate.csv;

create or replace table room_monthly_aggregate
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/room_monthly_aggregate.csv',
          file_format=>'csv_format'
        )
    )
);

copy into room_monthly_aggregate
from @files_stage/room_monthly_aggregate.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- staff
copy files
into @files_stage
from @datasets/branches/main/staff.csv;
create or replace table staff
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/staff.csv',
          file_format=>'csv_format'
        )
    )
);
copy into staff
from @files_stage/staff.csv
file_format = csv_format
match_by_column_name = case_insensitive;


create or replace table amenity
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/amenity.csv',
          file_format=>'csv_format'
        )
    )
);

copy into amenity
from @files_stage/amenity.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- guest
copy files
into @files_stage
from @datasets/branches/main/guest.csv;

create or replace table guest
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/guest.csv',
          file_format=>'csv_format'
        )
    )
);

copy into guest
from @files_stage/guest.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- hotel
copy files
into @files_stage
from @datasets/branches/main/hotel.csv;
create or replace table hotel
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/hotel.csv',
          file_format=>'csv_format'
        )
    )
);

copy into hotel
from @files_stage/hotel.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- invoice
copy files
into @files_stage
from @datasets/branches/main/invoice.csv;
create or replace table invoice
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/invoice.csv',
          file_format=>'csv_format'
        )
    )
);  
copy into invoice
from @files_stage/invoice.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- payment
copy files
into @files_stage
from @datasets/branches/main/payment.csv;
create or replace table payment
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/payment.csv',
          file_format=>'csv_format'
        )
    )
);
copy into payment
from @files_stage/payment.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- reservation  
copy files
into @files_stage
from @datasets/branches/main/reservation.csv;

create or replace table reservation
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/reservation.csv',
          file_format=>'csv_format'
        )
    )
);  
copy into reservation
from @files_stage/reservation.csv
file_format = csv_format
match_by_column_name = case_insensitive;


-- reservation_amenity
copy files
into @files_stage
from @datasets/branches/main/reservation_amenity.csv;
create or replace table reservation_amenity
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/reservation_amenity.csv',
          file_format=>'csv_format'
        )
    )
);
copy into reservation_amenity
from @files_stage/reservation_amenity.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- room
copy files
into @files_stage
from @datasets/branches/main/room.csv;
create or replace table room
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/room.csv',
          file_format=>'csv_format'
        )
    )
);

copy into room
from @files_stage/room.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- room_monthly_aggregate
copy files
into @files_stage
from @datasets/branches/main/room_monthly_aggregate.csv;

create or replace table room_monthly_aggregate
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/room_monthly_aggregate.csv',
          file_format=>'csv_format'
        )
    )
);

copy into room_monthly_aggregate
from @files_stage/room_monthly_aggregate.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- staff
copy files
into @files_stage
from @datasets/branches/main/staff.csv;
create or replace table staff
using template (
    select array_agg(object_construct(*))
    from table(
        infer_schema(
          location=>'@files_stage/staff.csv',
          file_format=>'csv_format'
        )
    )
);
copy into staff
from @files_stage/staff.csv
file_format = csv_format
match_by_column_name = case_insensitive;

-- make casing case_insensitive

ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "subtotal" TO SUBTOTAL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "loyalty_points" TO LOYALTY_POINTS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "paid_date" TO PAID_DATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "paid_amount" TO PAID_AMOUNT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "total_revenue" TO TOTAL_REVENUE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION_AMENITY" RENAME COLUMN "amenity_id" TO AMENITY_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "room_id" TO ROOM_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "tax_amount" TO TAX_AMOUNT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "room_revenue" TO ROOM_REVENUE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "salary" TO SALARY;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "paid" TO PAID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "name" TO NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "room_id" TO ROOM_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "month" TO MONTH;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "capacity" TO CAPACITY;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "phone" TO PHONE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION_AMENITY" RENAME COLUMN "nights" TO NIGHTS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "total_amount" TO TOTAL_AMOUNT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."AMENITY" RENAME COLUMN "price_per_night" TO PRICE_PER_NIGHT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "opened_date" TO OPENED_DATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "check_out" TO CHECK_OUT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "occupied_days" TO OCCUPIED_DAYS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "postcode" TO POSTCODE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "tax_amount" TO TAX_AMOUNT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "hire_date" TO HIRE_DATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "invoice_id" TO INVOICE_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "state_abbr" TO STATE_ABBR;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "last_name" TO LAST_NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "hotel_id" TO HOTEL_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "reservation_id" TO RESERVATION_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "room_rate" TO ROOM_RATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "full_name" TO FULL_NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "room_id" TO ROOM_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "adults" TO ADULTS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "estimated_amenities_total" TO ESTIMATED_AMENITIES_TOTAL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "loyalty_member" TO LOYALTY_MEMBER;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "tax_rate" TO TAX_RATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION_AMENITY" RENAME COLUMN "amount" TO AMOUNT;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "base_rate" TO BASE_RATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "hotel_id" TO HOTEL_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "full_name" TO FULL_NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "children" TO CHILDREN;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "stay_length" TO STAY_LENGTH;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "is_smoking" TO IS_SMOKING;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "total" TO TOTAL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "floor" TO FLOOR;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "number_of_reservations" TO NUMBER_OF_RESERVATIONS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION_AMENITY" RENAME COLUMN "reservation_amenity_id" TO RESERVATION_AMENITY_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."AMENITY" RENAME COLUMN "included" TO INCLUDED;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "street_address" TO STREET_ADDRESS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "reservation_id" TO RESERVATION_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "hotel_id" TO HOTEL_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "subtotal" TO SUBTOTAL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "reservation_id" TO RESERVATION_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."INVOICE" RENAME COLUMN "issue_date" TO ISSUE_DATE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "staff_id" TO STAFF_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "guest_id" TO GUEST_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "booking_channel" TO BOOKING_CHANNEL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "invoice_id" TO INVOICE_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "role" TO ROLE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "payment_id" TO PAYMENT_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."AMENITY" RENAME COLUMN "name" TO NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "room_type" TO ROOM_TYPE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "rating" TO RATING;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "check_in" TO CHECK_IN;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "phone" TO PHONE;
ALTER TABLE "DASH_DB_SI"."HOTEL"."STAFF" RENAME COLUMN "hotel_id" TO HOTEL_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."AMENITY" RENAME COLUMN "amenity_id" TO AMENITY_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM" RENAME COLUMN "room_number" TO ROOM_NUMBER;
ALTER TABLE "DASH_DB_SI"."HOTEL"."HOTEL" RENAME COLUMN "city" TO CITY;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "email" TO EMAIL;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION" RENAME COLUMN "payment_status" TO PAYMENT_STATUS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."PAYMENT" RENAME COLUMN "method" TO METHOD;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "guest_id" TO GUEST_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."GUEST" RENAME COLUMN "first_name" TO FIRST_NAME;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "number_of_available_days" TO NUMBER_OF_AVAILABLE_DAYS;
ALTER TABLE "DASH_DB_SI"."HOTEL"."RESERVATION_AMENITY" RENAME COLUMN "reservation_id" TO RESERVATION_ID;
ALTER TABLE "DASH_DB_SI"."HOTEL"."ROOM_MONTHLY_AGGREGATE" RENAME COLUMN "hotel_id" TO HOTEL_ID;
