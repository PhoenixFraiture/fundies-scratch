use context dcic2024

include csv
include data-source

workouts = table: date :: String, activity :: String, duration :: Number
  row: "2025-04-01", "Running", 30
  row: "2025-04-02", "Yoga", 45
  row: "2025-04-03", "Cycling", 60
end

workouts

      
recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://pdi.run/f25-2000-recipes.csv", default-options)
  sanitize servings using num-sanitizer
  sanitize prep-time using num-sanitizer
    
end
      
recipes

plants = load-table:
  plant_common_name :: String,
  location_latitude :: Number,
  location_longitude :: Number,
  date_sighted :: Number,
  soil_type :: String,
  plant_height_cm :: Number,
  plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
  sanitize location_latitude using num-sanitizer
  sanitize location_longitude using num-sanitizer
  sanitize plant_height_cm using num-sanitizer

end

plants.row-n(8)

glucose = load-table:
  patient_id,
  glucose_level,
  date_time,
  insulin_dose,
  exercise_duration,
  stress_level
  source: csv-table-file("glucose_levels.csv", default-options)
  sanitize patient_ie using num-sanitizer      
  sanitize insulin_dose using num-sanitizer 
  sanitize exercise_duration using num-sanitizer    
  sanitize stress_level using num-sanitizer  
  sanitize glucose_level using num-sanitizer    
end
