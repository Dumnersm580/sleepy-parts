Sequel.migration do
  up do
    alter_table(:projects) do
      set_column_type :part_number_prefix, String
    end
  end
end
