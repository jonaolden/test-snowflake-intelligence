
CALL SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(
    'dash_db_si.hotel',
  $$
name: HOTEL_SEMANTIC_VIEW
description: |-
  A hospitality operations and finance semantic model that links hotels,
    rooms, amenities, guests, staff, reservations, invoices, and payments to support
    analytics on occupancy and booking trends, revenue and payments, amenity usage,
    and staffing and billing efficiencies.
tables:
  - name: AMENITY
    description: The amenity table lists services or features available for accommodations, with each record containing an amenity_id, the amenity name, a price_per_night, and a flag indicating whether the amenity is included in the base rate.
    base_table:
      database: DASH_DB_SI
      schema: PUBLIC
      table: AMENITY
    dimensions:
      - name: INCLUDED
        description: Specifies whether the amenity is provided as part of the base offering (for example, premium Wi‑Fi or gym access) rather than requiring an additional purchase.
        expr: INCLUDED
        data_type: BOOLEAN
      - name: NAME
        description: The standardized name of a guest amenity offered by a property (e.g., breakfast, parking, premium Wi‑Fi, spa access), used to catalogue, filter, and report on services available across listings.
        expr: NAME
        data_type: VARCHAR(16777216)
    facts:
      - name: AMENITY_ID
        description: Foreign key reference to amenity
        expr: AMENITY_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: price_per_night
        description: The nightly fee charged to guests for use or rental of the amenity, representing the revenue earned per night from that amenity.
        expr: PRICE_PER_NIGHT
        data_type: NUMBER(38,2)
        access_modifier: public_access
    primary_key:
      columns:
        - AMENITY_ID
  - name: GUEST
    description: Represents individual guests and their contact information, storing identifiers and names (guest_id, first_name, last_name, full_name), email and phone. Also records loyalty program membership and accumulated points (loyalty_member, loyalty_points) for rewards and segmentation.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: GUEST
    dimensions:
      - name: GUEST_ID
        description: Foreign key reference to guest
        expr: guest_id
        data_type: NUMBER(38,0)
  - name: HOTEL
    description: Represents individual hotel properties, storing identifying and contact information along with location and performance metadata. Each record includes a unique hotel_id, name, full address (street_address, city, state_abbr, postcode), phone, rating, and opened_date.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: HOTEL
    dimensions:
      - name: CITY
        description: City where the hotel is located. Used for regional reporting, market segmentation, and analyzing occupancy, revenue, and booking trends by location.
        expr: CITY
        data_type: VARCHAR(16777216)
      - name: NAME
        description: The public-facing name of the hotel property (brand and location) used to identify the hotel in listings, bookings, marketing, and reports.
        expr: NAME
        data_type: VARCHAR(16777216)
      - name: PHONE
        description: The hotel's primary contact phone number used for reservations, guest inquiries, and operational communications.
        expr: PHONE
        data_type: VARCHAR(16777216)
      - name: STATE_ABBR
        description: Two-letter postal abbreviation for the U.S. state where the hotel is located, used for regional reporting, segmentation, and regulatory or tax-related analyses.
        expr: STATE_ABBR
        data_type: VARCHAR(16777216)
      - name: STREET_ADDRESS
        description: The street-level mailing address of the hotel property, used to identify its physical location for guest directions, deliveries, and location-based reporting.
        expr: STREET_ADDRESS
        data_type: VARCHAR(16777216)
    time_dimensions:
      - name: OPENED_DATE
        description: The calendar date when the hotel first opened to guests and began operations. This is used to determine property age and lifecycle stage for performance, maintenance, and investment analysis.
        expr: OPENED_DATE
        data_type: DATE
    facts:
      - name: HOTEL_ID
        description: Foreign key reference to hotel
        expr: HOTEL_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: POSTCODE
        description: The hotel's postal code (e.g., ZIP), identifying its mailing area and supporting location-based operations, regional reporting, and market segmentation.
        expr: POSTCODE
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RATING
        description: Aggregated guest satisfaction score for the hotel on a 1–5 scale, indicating overall quality as perceived by guests; higher scores reflect better guest experiences. Values typically fall between 2.5 and 5.0.
        expr: RATING
        data_type: NUMBER(38,1)
        access_modifier: public_access
    primary_key:
      columns:
        - HOTEL_ID
  - name: INVOICE
    description: Represents invoices issued for reservations, recording the invoice ID and linked reservation, issue date, monetary breakdown (subtotal, tax amount, total), and whether the invoice has been paid.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: INVOICE
    dimensions:
      - name: PAID
        description: 'Indicates whether the invoice has been settled: true when the related reservation was paid and false otherwise.'
        expr: PAID
        data_type: BOOLEAN
    time_dimensions:
      - name: ISSUE_DATE
        description: The date on which the invoice was issued to the customer, representing the billing date for the transaction. It is used to determine the accounting period and calculate payment due dates.
        expr: ISSUE_DATE
        data_type: DATE
    facts:
      - name: INVOICE_ID
        description: Foreign key reference to invoice
        expr: INVOICE_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RESERVATION_ID
        description: Foreign key reference to reservation
        expr: RESERVATION_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: SUBTOTAL
        description: The invoice subtotal is the monetary total of the associated reservation's items or services before taxes, fees, and discounts, carried over directly from the reservation record.
        expr: SUBTOTAL
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TAX_AMOUNT
        description: The total tax charged on the invoice for the associated reservation. It represents the portion of the invoice total attributable to taxes applied to that reservation.
        expr: TAX_AMOUNT
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TOTAL
        description: Total amount billed on the invoice for the linked reservation, representing the reservation's full charge.
        expr: TOTAL
        data_type: NUMBER(38,2)
        access_modifier: public_access
    primary_key:
      columns:
        - INVOICE_ID
  - name: PAYMENT
    description: Records individual payments tied to invoices or reservations, capturing the unique payment_id, linked invoice_id or reservation_id, paid_amount, paid_date, and payment method. This table is used to track payment history, reconcile transactions, and support billing and reporting.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: PAYMENT
    dimensions:
      - name: METHOD
        description: The method used to settle a payment for a transaction (e.g., credit card, cash, bank transfer, mobile pay). This enables analysis of customer payment preferences and supports reconciliation and fraud monitoring.
        expr: METHOD
        data_type: VARCHAR(16777216)
    time_dimensions:
      - name: PAID_DATE
        description: The calendar date when a payment was made or recorded, representing when the obligation was settled. Used for reporting, reconciliation, and analyzing payment timing and cash flow.
        expr: PAID_DATE
        data_type: DATE
    facts:
      - name: INVOICE_ID
        description: Foreign key reference to invoice
        expr: INVOICE_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: PAID_AMOUNT
        description: The monetary amount recorded for this payment, representing the portion of the associated invoice's total that was paid. It's used to track how much was applied toward the invoice balance.
        expr: PAID_AMOUNT
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: PAYMENT_ID
        description: Foreign key reference to payment
        expr: PAYMENT_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RESERVATION_ID
        description: Foreign key reference to reservation
        expr: RESERVATION_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
  - name: RESERVATION
    description: Represents hotel room bookings where each record ties a guest to a specific room and hotel with stay dates, duration, and occupancy details. It also captures pricing and payment information, including room rate, estimated amenities, taxes and totals, booking channel, and payment status.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: RESERVATION
    dimensions:
      - name: BOOKING_CHANNEL
        description: Identifies the channel through which a reservation was made (direct, OTA, corporate, or phone). Used to analyze booking sources, distribution performance, and revenue attribution.
        expr: BOOKING_CHANNEL
        data_type: VARCHAR(16777216)
      - name: PAYMENT_STATUS
        description: Indicates whether a reservation's payment has been completed, remains outstanding, or is awaiting confirmation, used to monitor revenue collection and trigger follow-up or fulfillment actions.
        expr: PAYMENT_STATUS
        data_type: VARCHAR(16777216)
    time_dimensions:
      - name: CHECK_IN
        description: The scheduled date (and time) when a guest is expected to arrive and begin their stay for the reservation.
        expr: CHECK_IN
        data_type: DATE
      - name: CHECK_OUT
        description: The scheduled departure date for the reservation, indicating the day the guest is expected to check out and the booking concludes. It's used to determine room availability, billing end date, and occupancy calculations.
        expr: CHECK_OUT
        data_type: DATE
    facts:
      - name: ADULTS
        description: Indicates the number of adult guests for the reservation (typically 1 or 2), used to inform occupancy planning, pricing, and resource allocation.
        expr: ADULTS
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: CHILDREN
        description: Number of children included in the reservation party (typically 0–3), used to inform seating allocation, menu planning, and family-focused offers.
        expr: CHILDREN
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ESTIMATED_AMENITIES_TOTAL
        description: Estimated total cost of optional amenities associated with the reservation. Used to forecast add‑on revenue and understand expected guest spend on extras.
        expr: ESTIMATED_AMENITIES_TOTAL
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: GUEST_ID
        description: Foreign key reference to guest
        expr: GUEST_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: HOTEL_ID
        description: Foreign key reference to hotel
        expr: HOTEL_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RESERVATION_ID
        description: Foreign key reference to reservation
        expr: RESERVATION_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_ID
        description: Foreign key reference to room
        expr: ROOM_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_RATE
        description: The standard base price for the reserved room applied to this booking, representing the core nightly charge before taxes and additional fees.
        expr: ROOM_RATE
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: STAY_LENGTH
        description: Duration of the guest's booking in nights, indicating how many consecutive nights the reservation covers (typically between 1 and 14 nights).
        expr: STAY_LENGTH
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: SUBTOTAL
        description: Estimated pre-tax charge for the reservation, representing the room charges (room rate × stay length) plus estimated amenity costs, rounded to two decimal places.
        expr: SUBTOTAL
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TAX_AMOUNT
        description: Total tax charged for the reservation, representing the sales or occupancy tax applied to the reservation subtotal.
        expr: TAX_AMOUNT
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TAX_RATE
        description: The tax_rate indicates the percentage tax applied to a reservation's taxable charges—by default 0.12 (12%)—used to calculate the tax amount added to the reservation total.
        expr: TAX_RATE
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TOTAL_AMOUNT
        description: Total amount payable for the reservation, representing the subtotal plus any applicable taxes. This is the final charge presented to the customer, rounded to two decimal places.
        expr: TOTAL_AMOUNT
        data_type: NUMBER(38,2)
        access_modifier: public_access
    primary_key:
      columns:
        - RESERVATION_ID
  - name: RESERVATION_AMENITY
    description: A mapping table that represents amenity line-items for a reservation, linking reservation_id to amenity_id and recording how many nights the amenity applies to and the charged amount.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: RESERVATION_AMENITY
    facts:
      - name: AMENITY_ID
        description: Foreign key reference to amenity
        expr: AMENITY_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: AMOUNT
        description: Total cost charged for the selected amenity over the reservation period, representing the aggregate amount billed for that amenity across all nights.
        expr: AMOUNT
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: NIGHTS
        description: Number of nights the guest will stay for the reservation associated with this amenity, representing the reservation's length of stay.
        expr: NIGHTS
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RESERVATION_AMENITY_ID
        description: Foreign key reference to reservation_amenity
        expr: RESERVATION_AMENITY_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: RESERVATION_ID
        description: Foreign key reference to reservation
        expr: RESERVATION_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
  - name: ROOM
    description: Represents individual hotel rooms, with each row recording a specific room's identifiers and attributes (hotel_id, room_number, floor, room_type, capacity, base_rate) and whether smoking is permitted.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: ROOM
    dimensions:
      - name: IS_SMOKING
        description: Specifies whether the room is designated as smoking or non‑smoking for guest booking and room assignment. Suites are always classified as non‑smoking.
        expr: IS_SMOKING
        data_type: BOOLEAN
      - name: ROOM_TYPE
        description: Categorizes each room by its service level and features (e.g., standard, deluxe, suite, family, accessible). Used to drive pricing, inventory allocation, reporting, and matching rooms to guest preferences and accessibility requirements.
        expr: ROOM_TYPE
        data_type: VARCHAR(16777216)
    facts:
      - name: BASE_RATE
        description: The base nightly rate for a room, established from the room type and hotel rating as the starting price before taxes, fees, or discounts.
        expr: BASE_RATE
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: CAPACITY
        description: 'Maximum number of guests the room is intended to accommodate, determined by room type (for example: family = 5, suite = 4, accessible = 2; other types default to 2).'
        expr: CAPACITY
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: FLOOR
        description: The floor indicates the building level where a room is located and is used to group rooms for operations, occupancy reporting, wayfinding, and maintenance scheduling.
        expr: FLOOR
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: HOTEL_ID
        description: Foreign key reference to hotel
        expr: HOTEL_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_ID
        description: Foreign key reference to room
        expr: ROOM_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_NUMBER
        description: Identifier for a specific room within a property used to locate and reference rooms for bookings, maintenance, and operational reporting.
        expr: ROOM_NUMBER
        data_type: NUMBER(38,0)
        access_modifier: public_access
    primary_key:
      columns:
        - ROOM_ID
  - name: ROOM_MONTHLY_AGGREGATE
    description: Monthly aggregated performance metrics for each hotel room, recording the number of reservations, occupied and available days, and room and total revenue for a given month.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: ROOM_MONTHLY_AGGREGATE
    dimensions:
      - name: MONTH
        description: The calendar month (e.g., "March 2025") that the room-level metrics are aggregated for, used to group and analyze monthly room performance.
        expr: MONTH
        data_type: VARCHAR(16777216)
      - name: NUMBER_OF_AVAILABLE_DAYS
        description: Count of days in the month when the room was available for booking according to the hotel's custom calendar.
        expr: NUMBER_OF_AVAILABLE_DAYS
        data_type: NUMBER(38,0)
      - name: NUMBER_OF_RESERVATIONS
        description: Total number of reservations for the room in the given month, representing how many bookings were made or held during that period.
        expr: NUMBER_OF_RESERVATIONS
        data_type: NUMBER(38,0)
      - name: OCCUPIED_DAYS
        description: The total number of days in the month that the room was occupied, representing monthly room utilization and used to track occupancy performance.
        expr: OCCUPIED_DAYS
        data_type: NUMBER(38,0)
    facts:
      - name: HOTEL_ID
        description: Foreign key reference to hotel
        expr: HOTEL_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_ID
        description: Foreign key reference to room
        expr: ROOM_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: ROOM_REVENUE
        description: Monthly total revenue from guest room sales, representing income generated by room rates and occupancy for that month (excluding non-room revenue such as food, beverage, and ancillary services).
        expr: ROOM_REVENUE
        data_type: NUMBER(38,2)
        access_modifier: public_access
      - name: TOTAL_REVENUE
        description: Total revenue generated by the room for the month, representing all room-related income such as nightly rates, fees, and applicable add‑ons.
        expr: TOTAL_REVENUE
        data_type: NUMBER(38,2)
        access_modifier: public_access
    metrics:
      - name: AVERAGE_DAILY_RATE
        description: 'Average Daily Rate (ADR): room revenue earned per occupied room-night. Formula: $\frac{\sum room\_revenue}{\sum occupied\_days}$'
        expr: SUM(room_monthly_aggregate.room_revenue) / NULLIF(SUM(room_monthly_aggregate.NUMBER_OF_AVAILABLE_DAYS), 0)
        access_modifier: public_access
      - name: OCCUPANCY_RATE
        description: 'Percentage of available room-nights sold. Formula: $\frac{\sum occupied\_days}{\sum available\_days}$'
        expr: SUM(room_monthly_aggregate.occupied_days) / NULLIF(SUM(room_monthly_aggregate.NUMBER_OF_AVAILABLE_DAYS), 0)
        access_modifier: public_access
      - name: REVPAR
        description: 'Revenue per Available Room (RevPAR): room revenue per available room-night combining occupancy and rate.'
        expr: SUM(room_monthly_aggregate.room_revenue) / NULLIF(SUM(room_monthly_aggregate.occupied_days), 0)
        access_modifier: public_access
  - name: STAFF
    description: Stores records of hotel staff members, including a unique staff ID, associated hotel ID, full name, role/position, hire date, and salary.
    base_table:
      database: DASH_DB_SI
      schema: HOTEL
      table: STAFF
    dimensions:
      - name: FULL_NAME
        description: The full name of a staff member used to identify and report on employees across business processes and records.
        expr: FULL_NAME
        data_type: VARCHAR(16777216)
      - name: ROLE
        description: The staff role denotes each employee's primary job function (e.g., front_desk, housekeeping, manager, concierge, maintenance, chef) and is used for staffing decisions, scheduling, and operational reporting.
        expr: ROLE
        data_type: VARCHAR(16777216)
    time_dimensions:
      - name: HIRE_DATE
        description: The official start date when the staff member began employment with the organization, used to track tenure, eligibility for benefits, and employment history.
        expr: HIRE_DATE
        data_type: DATE
    facts:
      - name: HOTEL_ID
        description: Foreign key reference to hotel
        expr: HOTEL_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
      - name: SALARY
        description: Estimated annual salary for each staff member reflecting typical pay levels by role with slight variation; used for payroll, budgeting, compensation analysis, and workforce cost modeling.
        expr: SALARY
        data_type: NUMBER(38,1)
        access_modifier: public_access
      - name: STAFF_ID
        description: Foreign key reference to staff
        expr: STAFF_ID
        data_type: NUMBER(38,0)
        access_modifier: public_access
    primary_key:
      columns:
        - STAFF_ID
relationships:
  - name: INVOICE_TO_RESERVATION
    left_table: INVOICE
    right_table: RESERVATION
    relationship_columns:
      - left_column: RESERVATION_ID
        right_column: RESERVATION_ID
    relationship_type: many_to_one
    join_type: left_outer
  - name: PAYMENT_TO_INVOICE
    left_table: PAYMENT
    right_table: INVOICE
    relationship_columns:
      - left_column: INVOICE_ID
        right_column: INVOICE_ID
    relationship_type: many_to_one
    join_type: left_outer
  - name: RESERVATION_AMENITY_TO_AMENITY
    left_table: RESERVATION_AMENITY
    right_table: AMENITY
    relationship_columns:
      - left_column: AMENITY_ID
        right_column: AMENITY_ID
    relationship_type: many_to_one
    join_type: left_outer
  - name: RESERVATION_AMENITY_TO_RESERVATION
    left_table: RESERVATION_AMENITY
    right_table: RESERVATION
    relationship_columns:
      - left_column: RESERVATION_ID
        right_column: RESERVATION_ID
    relationship_type: many_to_one
    join_type: left_outer
  - name: ROOM_TO_HOTEL
    left_table: ROOM
    right_table: HOTEL
    relationship_columns:
      - left_column: HOTEL_ID
        right_column: HOTEL_ID
    relationship_type: many_to_one
    join_type: left_outer
  - name: STAFF_TO_HOTEL
    left_table: STAFF
    right_table: HOTEL
    relationship_columns:
      - left_column: HOTEL_ID
        right_column: HOTEL_ID
    relationship_type: many_to_one
    join_type: left_outer
verified_queries:
  - name: Which month had the highest occupancy rate?
    question: Which month had the highest occupancy rate?
    sql: |-
      SELECT
        month,
        SUM(occupied_days) / NULLIF(NULLIF(SUM(number_of_available_days), 0), 0) AS occupancy_rate
      FROM
        room_monthly_aggregate
      GROUP BY
        month
      ORDER BY
        occupancy_rate DESC NULLS LAST
      LIMIT
        1
    use_as_onboarding_question: false
    verified_by: Jonatan Oldenburg
    verified_at: 1759396600
  - name: What whas the average daily rate in that same month?
    question: What whas the average daily rate in the month that had the highest occupancy rate?
    sql: |-
      WITH monthly_metrics AS (
        SELECT
          month,
          SUM(room_revenue) AS total_room_revenue,
          SUM(occupied_days) AS total_occupied_days,
          SUM(occupied_days) / NULLIF(NULLIF(SUM(number_of_available_days), 0), 0) AS occupancy_rate
        FROM
          room_monthly_aggregate
        GROUP BY
          month
      ),
      highest_occupancy_month AS (
        SELECT
          month
        FROM
          monthly_metrics
        ORDER BY
          occupancy_rate DESC NULLS LAST
        LIMIT
          1
      )
      SELECT
        hom.month,
        mm.total_room_revenue / NULLIF(NULLIF(mm.total_occupied_days, 0), 0) AS average_daily_rate
      FROM
        highest_occupancy_month AS hom
        LEFT JOIN monthly_metrics AS mm ON hom.month = mm.month
    use_as_onboarding_question: false
    verified_by: Jonatan Oldenburg
    verified_at: 1759396640
  $$
);

