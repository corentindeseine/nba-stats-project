def triple_or_double_double(pts, ast, reb, blk, stl)
  array = [pts, ast, reb, blk, stl].reject { |stat| stat < 10 }
  if array.length == 2
    1
  elsif array.length > 2
    2
  else
    0
  end
end
