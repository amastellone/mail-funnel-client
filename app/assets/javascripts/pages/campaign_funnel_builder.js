/*
 * @name campaign_funnel_builder.js
 * @Author Matt Twardowski
 * 
 * @file
 * JQuery Handler for the Campaign Mail Funnel Builder
 *
 */

$(function() {

    //Static Values
    var app_id = $('#current_app_id').val();
    var campaign_id = $('#campaign_id_holder').val(); //Current Campaign ID
    var current_email_list_id = $('#current_email_list_id_holder').val(); //Current Email List ID
    var csrf_token = $('meta[name=csrf-token]').attr('content'); //CSRF TOKEN 

    //Components
    var $canvas = $('#funnel-builder-canvas');
    var campaign_email_list_text = $('#email_list_name'); //Email List Text Output under Campaign Info
    var campaign_email_select = $('#email_list_select'); //Campaign Email List Select Dropdown
    var delete_selected_button = $('#delete_selected_button'); //Campaign Job Delete Button
    var edit_selected_job = $('#edit_selected_button'); //Campaign Job Edit Button

    //Set Value of Select dropdown to current email list
    campaign_email_select.val(current_email_list_id);

    /*
    //Setup the initial flowchart
    $.ajax({
        method: "POST",
        data: {
            width: $(document).width(),
            app_id: app_id,
            campaign_id: campaign_id,
            CSRF: csrf_token,
            authenticity_token: csrf_token
        },
        dataType: "json",
        url: "/fbapi_index",
        cache: false,
        success: function(response) {
            console.log("AJAX Success");
            console.log(response);
            $canvas.flowchart(response);
        }
    });
    */


    /*
     * @function
     * On Campaign Email List Select Change:
     * 
     * 1. Updates the Email list text under the Campaign Info Panel
     * 2. Calls and AJAX request to update the campaigns email list
     * 3. Calls the correct modal upon succes/fail
     */
    campaign_email_select.on('change', function() {

        //Get the id and name of new email list
        var email_list_id = campaign_email_select.val();
        var email_list_name = $("option:selected", campaign_email_select).text()

        //Update the campaign email list in the campaign info
        campaign_email_list_text.html(email_list_name);

        //AJAX Call to controller to update the campaigns email list
        $.ajax({
            method: "POST",
            data: {
                width: $(document).width(),
                campaign_id: campaign_id,
                email_list_id: email_list_id,
                CSRF: csrf_token,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_update_email_list",
            cache: false,
            success: function(response) {
                console.log(response);
                var $canvas = $('#funnel-builder-canvas');
                $canvas.flowchart(response);
            }

        });



    });



});
