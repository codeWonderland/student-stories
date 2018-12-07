document.addEventListener("DOMContentLoaded", onLoad);

function onLoad(){
    // in onLoad()
    document.removeEventListener("DOMContentLoaded", onLoad);

    var students = null;

    // Check to see if we have students
    if (Modernizr.localstorage && localStorage.getItem('ccTuays') !== null) {

        // grab student data from localStorage
        students = JSON.parse(localStorage.getItem('ccTuays'));

        // Make sure data is not expired
        var twoHours = 1000 * 60 * 60 * 2, // 2 hours in milliseconds
            now = new Date().getTime();

        // if data is valid we build page
        if (students.date && now - students.date < twoHours) {
            students = students.records;
            handleStudents(students);

        }
        // otherwise we pretend we don't have any data
        else{
            students = null;
        }
    }

    // if we don't have any student data
    if(!students) {
        var studentDataScript = document.createElement('script');

        studentDataScript.src = 'https://forms.champlain.edu/googlespreadsheet/find/type/tradtuays?callback=processRawStudentData';
        document.getElementsByTagName('head')[0].appendChild(studentDataScript);
    }

    // grab all of the featured students
    [].slice.call(
        document.querySelectorAll('[data-student-id]')

    ).forEach(function(feat_student) {
        // for each student we add a click listener
        feat_student.addEventListener('click', function(element) {
            window.open(
                'https://www.champlain.edu/student-stories/tell-us-about-yourself(ie)/meet-your-classmates?row=' + element.getAttribute('data-student-id'),
                '_self'
            );
        })
    });
}

function processRawStudentData(data) {
    console.log('data fetched');
    // Some ugly error handling
    if (!data || !data.message || !Object.keys(data.message).length) {
        console.log('Had a problem loading student data! Data is: ');
        console.log(data);
        return;
    }

    // if our data is valid
    if(data && data.hasOwnProperty('message')) {
        // Sort by row
        for(var student of data.message) {
            if (student != null && student.hasOwnProperty('row')) {
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
}

// Function acquired from https://www.sitepoint.com/url-parameters-jquery/
function urlParam(name)
{
    var results = new RegExp('[\?&]' + name + '=([^$#]*)').exec(window.location.href);

    if (results == null)
        return null;
    else
        return results[1] || null;
}

function handleStudents(students){
    // For each student, format our student HTML and add it to the dom?
    // Or build up one long string and write to the dom once?
    var featuredStudentsString = '';
    // the function can return 0 or null, and in that case we want to just load the first row from the results
    var row = urlParam('row') || 1;
    var count = 0;
    var foundStudent = false;
    var maxFeatIndex = 3;

    featuredStudentsString += '<div class="featured-student-section" data-open="true">';

    // if we are on mobile
    if (window.matchMedia( "(max-width: 768px)" ).matches) {
        featuredStudentsString += '<div class="slideshow">';

    } else {
        featuredStudentsString += '<div class="row">';
    }

    students.some(function(student){
        // We want to have a limited number of students in the bottom gallery of featured students
        if (count < maxFeatIndex) {
            // If our current student is a featured student we don't want to use that as a promoted student
            // As the user is already looking at that student, so we increase the number in the bottom by
            // one and skip this index
            if (student.row === row) {
                maxFeatIndex++;

            } else {
                featuredStudentsString += formatFeaturedStudentHTML(student);
            }

            // we are only worried about updating the counter if we are still getting feauted students
            count++

        } else if (foundStudent) {
            return true;
        }

        // if this student is the one in the paramater then we will load it on our screen
        if (student.row === row)
        {
            foundStudent = true;

            // populate student container with data
            document.getElementById("student").innerHTML += formatStudentHTML(student);
        }
    });

    featuredStudentsString += '</div></div>';

    // populate featured students section
    document.getElementById("featured-students").innerHTML = featuredStudentsString;
}

function formatStudentHTML(student) {
    var result = '<div class="card-component main-student">' +
        '             <div class="card-component-image card-component-image-left">' +
        '                 <img class="student-image" src="' + student.image_url + '" alt="' + student.name + '">' +
        '             </div>' +
        '             <div class="card-text card-component-padded">' +
        '                 <h1 class="student-heading">' + student.name + ', \'' + student.year + '</h1>' +
        '                 <h2 class="student-major">' + student.major + '</h2>' +
        '                 <h2 class="student-hometown">' + student.hometown + '</h2>' +
        '             </div>' +
        '         </div>' +
        '         <div class="dots"></div>' +
        '         <p class="question">' + student.featured_question + '</p>' +
        '         <p class="answer">' + student.answer + '</p>';

    if (student.question_2)
    {
        result += '<p class="question">' + student.question_2 + '</p>' +
            '      <p class="answer">' + student.answer_2 + '</p>';
    }

    if (student.question_3)
    {
        result += '<p class="question">' + student.question_3 + '</p>' +
            '      <p class="answer">' + student.answer_3 + '</p>';
    }

    if (student.question_4)
    {
        result += '<p class="question">' + student.question_4 + '</p>' +
            '      <p class="answer">' + student.answer_4 + '</p>';
    }

    if (student.question_5)
    {
        result += '<p class="question">' + student.question_5 + '</p>' +
            '      <p class="answer">' + student.answer_5 + '</p>';
    }

    if (student.question_6)
    {
        result += '<p class="question">' + student.question_6 + '</p>' +
            '      <p class="answer">' + student.answer_6 + '</p>';
    }

    if (student.question_7)
    {
        result += '<p class="question">' + student.question_7 + '</p>' +
            '      <p class="answer">' + student.answer_7 + '</p>';
    }

    if (student.question_8)
    {
        result += '<p class="question">' + student.question_8 + '</p>' +
            '      <p class="answer">' + student.answer_8 + '</p>';
    }

    if (student.question_9)
    {
        result += '<p class="question">' + student.question_9 + '</p>' +
            '      <p class="answer">' + student.answer_9 + '</p>';
    }

    if (student.question_10)
    {
        result += '<p class="question">' + student.question_10 + '</p>' +
            '      <p class="answer">' + student.answer_10 + '</p>';
    }

    return result;
}

function formatFeaturedStudentHTML(student) {
    return '<div class="featured-student" data-student-id="' + student.row + '">' +
        '    <div class="featured-student-image">' +
        '       <img src="' + student.image_url + '" alt="featured student">' +
        '    </div>' +
        '    <div class="featured-student-data">' +
        '       <p class="featured-student-info">' + student.name + ', \'' + student.year + '</p>' +
        '       <p class="featured-student-quip">' + student.short_quip + '</p>' +
        '    </div>' +
        '</div>';
}