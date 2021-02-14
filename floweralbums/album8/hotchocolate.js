  test=false

  function back(name) {
	  part2 = (test==false)?"a.jpg":".jpg";
	  document[name].src = name + part2;
  }

  function front(name) {
	  part2 = (test==false)?".jpg":"a.jpg";
	  document[name].src = name + part2;
  }

  function tog(name) {
	if (onclick=true)
	{
	test=(test==false)?true:false
	}
  }
