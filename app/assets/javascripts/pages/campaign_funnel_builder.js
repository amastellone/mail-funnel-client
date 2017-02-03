/*
 * @name campaign_funnel_builder.js
 * @Author Matt Twardowski
 * 
 * @file
 * JQuery Handler for the Campaign Mail Funnel Builder
 *
 */

$(function() {

    $('#ajax-messages').on('ajax:error', function(event, xhr, status, error) {
        // TODO: SECURITY - Aadd Token here for secure ajax calls + add before_filter to controller
        ShopifyApp.flashError(xhr.responseText);
        $(this).append(xhr.responseText)
    });

    //Static Values
    var app_id = $('#current_app_id').val();
    var campaign_id = $('#campaign_id_holder').val(); //Current Campaign ID
    var current_email_list_id = $('#current_email_list_id_holder').val(); //Current Email List ID
    var canvas_height = $('#canvas_height_holder').val();
    var csrf_token = $('meta[name=csrf-token]').attr('content'); //CSRF TOKEN 
    var csrf_param = $('meta[name=csrf-param]').attr('content'); //CSRF PARAM - NOT SURE IF USED ANYWHERE

    //Components
    var $canvas = $('#funnel-builder-canvas');
    var campaign_email_list_text = $('#email_list_name'); //Email List Text Output under Campaign Info
    var campaign_email_select = $('#email_list_select'); //Campaign Email List Select Dropdown
    var delete_selected_button = $('#delete_selected_button'); //Campaign Job Delete Button
    var edit_selected_job = $('#edit_selected_button'); //Campaign Job Edit Button

    //Modal Components
    var edit_modal_submit_button = $('#edit_selected_button_submit');

    //Set Value of Select dropdown to current email list
    campaign_email_select.val(current_email_list_id);

    //Setup AJAX Headers
    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
    });
    $.ajax.bind("ajaxSend", function(elm, xhr, s) {
        if (s.type == "POST") {
            xhr.setRequestHeader('X-CSRF-Token', csrf_token);
        }
    });


    //Setup the initial flowchart on the page 
    $canvas.height(canvas_height);
    reloadCanvas();


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

    /*
     * @function
     * Updates the flowchart for the campaign
     * 
     */
    function reloadCanvas() {
        $.ajax.bind("ajaxSend", function(elm, xhr, s) {
            if (s.type == "POST") {
                xhr.setRequestHeader('X-CSRF-Token', csrf_token);
            }
        });

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
    }

    // UPDATE NODE
    edit_selected_job.click(function(event) {
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var jobId = nodeId.split("_")[1];

        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                job_id: jobId,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_read",
            cache: false,
            success: function(response) {
                $('#modal_node_update').modal('show');
                console.log("AJAX READ Success");
                console.log(response);

                $('#node_update_job_id').html(response['id']);
                $('#node_update_job_name').val(response['name']);

                $('#node_update_email_list_id').text(response['email_list_id']);

                $('#node_update_job_subject').val(response['subject']);
                $('#node_update_job_content').val(response['content']);

                $('#node_update_hook_identifier').text(response['hook_identifier']);

                $('#node_update_job_executed').text(response['executed']);
                $('#node_update_job_execute_time').text(response['execute_time']);
                $('#node_update_job_execute_frequency').val(response['execute_frequency']);

                $('#node_update_app_id').html(response['app_id']);
                $('#node_update_campaign_id').html(response['campaign_id']);
                $('#node_update_local_identifier').html('job_' + response['id']);

            }
        });

    });

    edit_modal_submit_button.click(function(event) {
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var jobId = nodeId.split("_")[1];

        // TODO: Verify we are not trying to modify a campaign (example below in delete submit)

        // TODO: Get the value of these, and set them to the data for the AJAX Call in data section below

        $('#node_update_email_list_id').val(response['email_list_id']);

        console.log('executed: ' + response['executed']);

        $('#node_update_job_executed').text(response['executed']);
        $('#node_update_job_execute_time').text(response['execute_time']);


        console.log('OperatorID: '.concat(nodeId));

        $('#modal_node_update').modal('show');

        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                job_id: $('#node_update_job_id').val(),
                name: $('#node_update_job_name').val(),
                subject: $('#node_update_job_subject').val(),
                content: $('#node_update_job_content').val(),
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_read",
            cache: false,
            success: function(response) {
                console.log("AJAX READ Success");


            }
        });

    });

    // CREATE NODE
    $('#create_button').click(function(event) {

        //$('#node_update_hook_identifier').text(<%= @campaign.hook_identifier %>);

        $('#node_update_app_id').text(app_id);
        $('#node_update_campaign_id').text(campaign_id);

        $('#modal_node_create').modal('show');

    });

    // CREATE NODE
    $('#create_button_submit').click(function(event) {

        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                app_id: app_id,
                campaign_id: campaign_id,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_create",
            cache: false,
            success: function(response) {
                // TODO: Verify this all works
                if (response['status'] === 'true') {
                    $('#result_modal').modal('show');
                    $('#result_status_message').text('Job was created succesfully');
                    // TODO: Also tell the user the new Job ID
                } else {
                    $('#result_modal').modal('show');
                    $('#result_status_message').text('Job was NOT created');
                }
            }
        });
    });

    // DELETE NODE
    $('#delete_selected_button').click(function() {
        // Modal to ask Yes / No to delete job
        $('#modal_node_delete').modal('show');
    });

    $('#node_status_acknowledge').click(function() {
        reload_canvas();
    });

    $('#delete_selected_button_submit').click(function() {
        // If user selectes YES delete this job
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var split = nodeId.split("_");
        var nodeType = split[0];
        var jobId = split[1];

        //Job ID: job_32
        //Campaign ID: campaign_0

        if (nodeType === 'campaign') {
            console.log("This is a campaign");
            //TODO: Make sure we canot delete the campaign
        }

        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                job_id: jobId,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_delete",
            cache: false,
            success: function(response) {
                console.log("AJAX DELETE Success");
                // TODO: Verify this all works
                if (response['status'] === 'true') {
                    $('#result_modal').modal('show');
                    $('#result_status_message').text('Job was deleted succesfully');
                } else {
                    $('#result_modal').modal('show');
                    $('#result_status_message').text('Job was NOT deleted created');
                }
            }
        });
        $canvas.flowchart('deleteSelected');
    });

    $canvas.siblings('.get_data').click(function() {
        var data = $canvas.flowchart('getData');
        $('#flowchart_data').val(JSON.stringify(flowchart_data, null, 2));
    });

    $('#node_delete_job_ok').click(function() {

    });

    function isJob() {
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var split = nodeId.split("_");
        var nodeType = split[0];
        var jobId = split[1];

        if (nodeType === 'job') {
            return true;
        }
    }

    function isCampaign() {
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var split = nodeId.split("_");
        var nodeType = split[0];
        var jobId = split[1];

        if (nodeType === 'campaign') {
            return true;
        }
    }

    function populateModal(response) {
        console.log(response['name']);

        console.log(response);

        $('#node_update_job_id').val(response['job_id']);
        $('#node_update_job_name').val(response['name']);

        $('#node_update_email_list_id').val(response['email_list_id']);

        $('#node_update_job_subject').val(response['subject']);
        $('#node_update_job_content').val(response['content']);

        $('#node_update_hook_identifier').text(response['hook_identifier']);

        console.log('executed: ' + response['executed']);

        $('#node_update_job_executed').text(response['executed']);
        $('#node_update_job_execute_time').text(response['execute_time']);
        $('#node_update_job_execute_frequency').val(response['execute_frequency']);

        $('#node_update_app_id').text(response['app_id']);
        $('#node_update_campaign_id').text(response['client_campaign']);
        $('#node_update_local_identifier').text(response['local_identifier']);
    }

    //      // Apply the plugin on a standard, empty div...
    //      $('#funnel-builder-canvas').flowchart({
    //          onOperatorSelect: function (operatorId) {
    //              if(isJob()) {
    //                  $('#delete_selected_button').show();
    //                  $('#delete_selected_button').show();
    //              }
    //              return true;
    //          },
    //          onOperatorUnselect: function () {
    //              if(isJob()) {
    //                  $('#delete_selected_button').hide();
    //                  $('#delete_selected_button').hide();
    //              }
    //              return true;
    //          }
    //      });

});
