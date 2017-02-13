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

    //Buttons
    var new_job_button = $('#create_button'); //Create New Job Button
    var delete_selected_button = $('#delete_selected_button'); //Campaign Job Delete Button
    var edit_selected_job_button = $('#edit_selected_button'); //Campaign Job Edit Button

    //Modals
    var create_new_job_modal = $('#modal_node_create'); //New Job Modal
    var update_job_modal = $('#modal_node_update'); //Update Job Modal
    var delete_job_modal = $('#modal_node_delete'); //Delete Job Modal
    var result_modal = $('#result_modal'); //Result Modal 
    var update_modal_success = $('#update_modal_success'); //Job Created Successfully Modal

    //Modal Components
    var edit_modal_submit_button = $('#update_job_submit'); //Edit Job Modal Submit Button
    var new_job_modal_submit_button = $('#new_job_submit'); //New Job Modal Submit Button
    var delete_job_modal_confirm_button = $('#modal_node_delete_confirm'); //Delete Job Modal Confirm Button


    //Set Value of Select dropdown to current email list
    campaign_email_select.val(current_email_list_id);

    //Hide the delete and edit selected buttons
    hideButtons();

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
        var email_list_name = $("option:selected", campaign_email_select).text();

        //Update the campaign email list in the campaign info
        campaign_email_list_text.html(email_list_name);

        //Update the email list id locally 
        current_email_list_id = email_list_id;

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
                $canvas.flowchart({
                    verticalConnection: true,
                    data: response,
                    linkWidth: 20,
                    grid: 25,
                    canUserEditLinks: false,
                    canUserMoveOperators: false,
                    onOperatorSelect: function(operatorId) {
                        showButtons(operatorId);
                        return true;
                    },
                    onOperatorUnselect: function() {
                        hideButtons();
                        return true;
                    }
                });
            }
        });
    }

    // UPDATE NODE
    edit_selected_job_button.click(function(event) {
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
                $('#node_id_hidden').val(response['id']);
                $('#node_update_job_name').val(response['name']);

                $('#node_update_email_list_id').text(response['email_list_id']);

                $('#node_update_job_subject').val(response['subject']);
                $('#node_update_job_content').val(response['content']);

                $('#node_update_hook_identifier').text(response['hook_identifier']);

                $('#node_update_job_executed').text(response['executed']);
                $('#node_update_execute_time').val(response['execute_time']);

                $('#node_update_app_id').html(response['app_id']);
                $('#node_update_campaign_id').html(response['campaign_id']);
                $('#node_update_local_identifier').html('job_' + response['id']);

            }
        });

    });

    edit_modal_submit_button.click(function(event) {
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var jobId = nodeId.split("_")[1];
        
        id = $('#node_id_hidden').val();
        name = $('#node_update_job_name').val();
        execute_time = $('#node_update_execute_time').val();
        subject = $('#node_update_job_subject').val();
        content = $('#node_update_job_content').val();


        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                job_id: id,
                name: name,
                execute_time: execute_time,
                subject: subject,
                content: content,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_update",
            cache: false,
            error: function(e) {
                console.log(e);
                //Close the Update Job Modal
                update_job_modal.modal('hide');

                //Display Error Result Modal
                $('#result_modal').modal('show');
                $('#result_modal_title').text('Error');
                $('#result_modal_text').text('Job was NOT updated!');
            },
            success: function(response) {
                //Close the Udate Job Modal
                update_job_modal.modal('hide');
                //Open result modal
                $('#result_modal').modal('show');
                $('#result_modal_title').text('Success');
                $('#result_modal_text').text('Job was updated succesfully!');
            }
        });

    });

    //On New Job Button Click
    new_job_button.click(function(event) {
    
        $('#node_new_app_id').text(app_id);
        $('#node_new_campaign_id').text(campaign_id);
        $('#node_new_email_list_id').text(current_email_list_id);

        create_new_job_modal.modal('show');

    });

    // CREATE NODE
    new_job_modal_submit_button.click(function(event) {

        //AJAX call to fbapi_create -- creates a new Job
        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                app_id: app_id,
                campaign_id: campaign_id,
                email_list_id: current_email_list_id,
                name: $('#node_new_job_name').val(),
                subject: $('#node_new_job_subject').val(),
                content: $('#node_new_job_content').val(),
                execute_time: $('#node_new_job_execute_time').val(),
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_create",
            cache: false,
            error: function(e) {
                console.log(e);
                //Close the Create New Job Modal
                create_new_job_modal.modal('hide');

                //Display Error Result Modal
                $('#result_modal').modal('show');
                $('#result_modal_title').text('Error');
                $('#result_modal_text').text('Job was NOT created');
            },
            success: function(response) {
                create_new_job_modal.modal('hide'); //Close the Create New Job Modal

                // Display result modal with the status returned by the controller
                if (response['status'] ===  true) {
                    $('#result_modal').modal('show');
                    $('#result_modal_title').text('Success');
                    $('#result_modal_text').text('Job was created succesfully!');
                    // TODO: Also tell the user the new Job ID
                } else {
                    $('#result_modal').modal('show');
                    $('#result_modal_title').text('Error');
                    $('#result_modal_text').text('Job was NOT created');
                }

            }
        });
    });

    // DELETE NODE
    delete_selected_button.click(function() {
        
        //Get Job ID from the funnel object
        var nodeId = $('#funnel-builder-canvas').flowchart('getSelectedOperatorId');
        var jobId = nodeId.split("_")[1];

        //AJAX Call to get the selected jobs info from DB
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
                //Open up confirmation modal
                delete_job_modal.modal('show');

                //Populate fields with Job info
                $('#node_delete_job_id').html(response['id']);
                $('#node_delete_id_hidden').val(response['id']);
                $('#node_delete_job_name').html(response['name']);

                $('#node_delete_email_subject').html(response['subject']);
                $('#node_delete_email_content').html(response['content']);
      
            }
        });

    });

    delete_job_modal_confirm_button.click(function() {
        //Get the Job ID from the hidden input field in modal
        jobID = $('#node_delete_id_hidden').val();

        //AJAX Call to delete the job
        var ajaxCall = $.ajax({
            method: "POST",
            data: {
                job_id: jobID,
                authenticity_token: csrf_token
            },
            dataType: "json",
            url: "/fbapi_delete",
            cache: false,
            error: function(e) {
                console.log(e);
                //Hide the current modal
                delete_job_modal.modal('hide');

                //Display Error Result Modal
                $('#result_modal').modal('show');
                $('#result_modal_title').text('Error');
                $('#result_modal_text').text('Job was NOT deleted!');
            },
            success: function(response) {
                //Hide the current modal
                delete_job_modal.modal('hide');
                
                //Open result modal with appropriate result message
                if (response['status'] === true) {
                    $('#result_modal').modal('show');
                    $('#result_modal_title').text('Success');
                    $('#result_modal_text').text('Job was deleted succesfully');
                } else {
                    $('#result_modal').modal('show');
                    $('#result_modal_title').text('Error');
                    $('#result_modal_text').text('Job was NOT deleted!');
                }
            }
        });
        $canvas.flowchart('deleteSelected');
    });

    $('#node_status_acknowledge').click(function() {
        reloadCanvas();
    });

    $canvas.siblings('.get_data').click(function() {
        var data = $canvas.flowchart('getData');
        $('#flowchart_data').val(JSON.stringify(flowchart_data, null, 2));
    });

    function isJob(operatorID) {
        var split = operatorID.split("_");
        var nodeType = split[0];
        var jobId = split[1];

        if (nodeType === 'job') {
            return true;
        }
    }

    function isCampaign(operatorID) {
        var split = operatorID.split("_");
        var nodeType = split[0];
        var jobId = split[1];

        if (nodeType === 'campaign') {
            return true;
        }
    }

    function showButtons(operatorID) {

        //If it is a campaign do not continue
        if (isCampaign(operatorID)) {
            return;
        }

        //Otherwise, show the delete and edit button
        delete_selected_button.show();
        edit_selected_job_button.show();

    } 

    function hideButtons() {
        delete_selected_button.hide();
        edit_selected_job_button.hide();
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

});
