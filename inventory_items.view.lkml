view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
measure: sum_cost {
  type: sum
  sql: ${cost} ;;
  filters:  {
    field: product_id
    value: "12345"
  }
}

measure: sum_test {
  type: number
  sql: case when ${sum_cost} = 0 then null
  else ${sum_cost}
  end;;
}

measure: divide {
  type: number
  sql: ${count}/ ${sum_cost} ;;
}
  measure: test_mult {
    type: number
    sql: ${cost} * ${products.retail_price} ;;
  }
}
