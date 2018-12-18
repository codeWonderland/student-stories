function handleStudents(students, gradYear){
    console.log(students);
    console.log('handling students');
    // For each student, format our student HTML and add it to the dom?
    // Or build up one long string and write to the dom once?
    var studentsString = '';
    var count = 0;
    $(students).filter(function(student) {
        return students[student].year === gradYear || students[student].year === "78"
    }).each(function(student){
        console.log(students[student]);
        if (count === 0 || count % 3 === 0)
        {
            if (count !== 0)
            {
                studentsString += '</div>';
            }

            studentsString += '<div class="row">';
        }
        studentsString += formatStudentHTML(students[student]);
        count++
    });

    $('#students').html(studentsString);
    $('[data-student-id]').click(function() {
        window.open('https://www.champlain.edu/student-stories/tell-us-about-yourself(ie)/meet-your-classmates?row=' + this.getAttribute('data-student-id'), '_self');
    });
}

function formatStudentHTML(spreadsheetEntry) {
    console.log('formatting a student');
    console.log(spreadsheetEntry);
    var result = '<div class="card-component gallery-student" data-student-id="' + spreadsheetEntry.row + '">';

    result += '     <div class="student-image">';

    result += '         <img style="max-width: unset!important; width: 100%; height: 250px; object-fit: cover;" src="' + spreadsheetEntry.image_url + '" alt="' + spreadsheetEntry.name + '">';

    result += '     </div>';

    result += '       <div class="card-component-padded card-text student-data">' +
        '                <h2 class="student-quip">"' + spreadsheetEntry.short_quip + '"</h2>';

    result += '          <p class="student-info">&mdash;' + spreadsheetEntry.name + (spreadsheetEntry.year !== "" ? ', \'' + spreadsheetEntry.year : '');

    result += '      </div>';

    result += '   </div>';

    return result;
}