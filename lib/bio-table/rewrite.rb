module BioTable

  module Rewrite

    # Rewrite fields. Both field and fields can be used, but not at the same time.
    def Rewrite::rewrite code, rowname, field
      fields = field.dup
      original = field.dup
      values = LazyValues.new(field)
      value = values
      return rowname,field if not code or code==""
      begin
        eval(code)
      rescue Exception
        $stderr.print "Failed to evaluate ",rowname," ",field," with ",code,"\n"
        raise 
      end
      if (fields & original != fields.uniq) and (field & original != field.uniq)
        $stderr.print [:original,original],"\n"
        $stderr.print [:fields,fields],"\n"
        $stderr.print [:field,field],"\n"
        raise "You can not rewrite both field and fields!"
      end
      field = fields if fields != original
      return rowname,field
    end
  end
end
