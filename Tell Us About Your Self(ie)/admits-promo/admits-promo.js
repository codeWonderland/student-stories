var ccWaitTries = 10;
(function waitForJQuery() {
    if (window.$)
    {
        (function($){
            console.log('in the anon function');
            $(document).ready(function(){
//                console.log('in the dom ready');
                var students = null;

                // See if we have students
                if (Modernizr.localstorage && localStorage.getItem('ccTuays') !== null) {
//                    console.log('have students lcoally');
                    students = $.parseJSON(localStorage.getItem('ccTuays'));
                    // Make sure data is not expired
                    var twoHours = 1000 * 60 * 60 * 2, // 2 hours in milliseconds
                        now = new Date().getTime();
                    if (students.date && now - students.date < twoHours) {
                        students = students.records;
                        handleStudents(students);
                    }
                    else{
                        students = null;
                    }
                }

                if(!students) {
//                    console.log('fetching students');
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
//                            console.log('data from sheet:');
//                            console.log(data);
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
                        handleStudents(students);
                    });
                }

                function handleStudents(students){
//                    console.log(students);
//                    console.log('handling students');
                    // For each student, format our student HTML and add it to the dom?
                    // Or build up one long string and write to the dom once?
                    var studentsString = '';
                    var count = 0;
                    $(students).each(function(student){
//                        console.log(students[student]);
                        if (count < 4)
                            studentsString += formatStudentHTML(students[student]);
                        count++
                    });
                    $('#students').html(studentsString);
                    $('[data-student-id]').click(function() {
                        window.open('https://www.champlain.edu/student-stories/tell-us-about-yourself(ie)/meet-your-classmates?row=' + this.getAttribute('data-student-id'), '_blank');
                    });
                }

                function formatStudentHTML(spreadsheetEntry) {
//                    console.log('formatting a student');
//                    console.log(spreadsheetEntry);
                    var result = '<div class="card-component student" data-student-id="' + spreadsheetEntry.row + '">' +
                        '           <div class="card-component-padded card-text student-data">' +
                        '                <p class="student-question">' + spreadsheetEntry.featured_question + '</p>' +
                        '                <div class="student-answer-container">';

                    if (spreadsheetEntry.sub_answer !== "") {
                        result += '         <h2 class="student-answer">"' + spreadsheetEntry.answer + '</h2>' +
                            '               <p class="student-sub-answer">' + spreadsheetEntry.sub_answer + '"</p>';
                    }
                    else
                    {
                        result += '         <h2 class="student-answer">"' + spreadsheetEntry.answer + '"</h2>';
                    }

                    result += '             <p class="student-info">&mdash;' + spreadsheetEntry.name + (spreadsheetEntry.year !== "" ? ', \'' + spreadsheetEntry.year : '') + ' // ' + spreadsheetEntry.major + ' // ' + spreadsheetEntry.hometown;

                    result += '         </div>';

                    result += '     </div>';

                    result += '     <div class="card-component-image card-component-image-right">';

                    result += '         <img src="' + spreadsheetEntry.image_url + '" alt="' + spreadsheetEntry.name + '">';

                    result += '     </div>';

                    result += '   </div>';

                    return result;
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