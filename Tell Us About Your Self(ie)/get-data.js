var ccWaitTries = 10;
(function waitForJQuery() {
    if (window.$)
    {
        (function($){
            console.log('in the anon function');
            $(document).ready(function(){
                console.log('in the dom ready');
                var students = null;

                // See if we have students
                if (Modernizr.localstorage && localStorage.getItem('ccTuays') !== null) {
                    console.log('have students lcoally');
                    students = $.parseJSON(localStorage.getItem('ccTuays'));
                    // Make sure data is not expired
                    var twoHours = 1000 * 60 * 60 * 2, // 2 hours in milliseconds
                        now = new Date().getTime();
                    if (students.date && now - students.date < twoHours) {
                        students = students.records;
                        handleStudents(students, "21");
                    }
                    else{
                        students = null;
                    }
                }

                if(!students) {
                    console.log('fetching students');
                    // Go get our students
                    var $xhrStudents = $.ajax({
                        url: "https://forms.champlain.edu/googlespreadsheet/find/type/tradtuays",
                        dataType: "jsonp"
                    });

                    $xhrStudents.done(function(data){
                        // Some ugly error handling
                        if (!data || !data.message || !Object.keys(data.message).length) {
                            console.log('Had a problem loading student data! Data is: ');
                            console.log(data);
                            return;
                        }


                        if(data){
                            console.log('data from sheet:');
                            console.log(data);
                            try {
                                // Sort by row
                                for(var student in data.message) {
                                    if(student.hasOwnProperty('row')){
                                        data.sort(function(a,b){
                                            if(a.row > b.row){
                                                return 1;
                                            }
                                            if(a.row < b.row) {
                                                return -1;
                                            }
                                            return 0;
                                        });
                                    }
                                }
                            } catch(e){
                                console.log(e);
                            }
                        }

                        // Now store our data locally
                        var storedData = {
                            records: data.message,
                            date: new Date().getTime()
                        };

                        if (Modernizr.localstorage && JSON && JSON.stringify) {
                            localStorage.setItem('ccTuays', JSON.stringify(storedData));
                        }

                        students = storedData.records;
                        handleStudents(students, "21");
                    });
                }



            });
        })(jQuery);
    }
    else
    {
        ccWaitTries--;
        if (ccWaitTries > 0)
        {
            setTimeout(waitForJQuery, 50);
        }
    }
})();