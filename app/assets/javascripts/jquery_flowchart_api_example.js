
$(document).ready(function () {
	var flowchart_data = {
		"operators": {
			"operators": {
				"campaign_0": {
					"top": "0",
					"left": "80",
					"multipleLinksOnInput": "true",
					"properties": {
						"title": "Campaign",
						"inputs": {
						},
						"outputs": {
							"output_1": {
								"label": "Cart / Create Jobs:"
							}
						}
					}
				},
				"campaign_1": {
					"top": "150",
					"left": "80",
					"multipleLinksOnInput": "true",
					"properties": {
						"title": "Campaign",
						"inputs": {
						},
						"outputs": {
							"output_1": {
								"label": "Cart / Update Jobs:"
							}
						}
					}
				},
				"campaign_2": {
					"top": "300",
					"left": "80",
					"multipleLinksOnInput": "true",
					"properties": {
						"title": "Campaign",
						"inputs": {
						},
						"outputs": {
							"output_1": {
								"label": "Cart / Abandon Jobs:"
							}
						}
					}
				},
				"job_1": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Incredible Wool Knife"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_2": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Heavy Duty Silk Plate"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_3": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Incredible Copper Bag"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_4": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Aerodynamic Concrete Bag"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_5": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Rustic Steel Lamp"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_6": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Rustic Granite Knife"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_7": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Awesome Marble Pants"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_8": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Rustic Iron Car"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_9": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Durable Cotton Bench"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_10": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Sleek Linen Car"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_11": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Ergonomic Aluminum Chair"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_12": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Sleek Paper Wallet"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_13": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Heavy Duty Wooden Wallet"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_14": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Fantastic Copper Shirt"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				},
				"job_15": {
					"top": "300",
					"left": "180",
					"multipleLinksOnInput": "false",
					"properties": {
						"title": "Email Job",
						"inputs": {
							"input_1": {
								"label": "Synergistic Linen Lamp"
							}
						},
						"outputs": {
							"output_1": {
								"label": "Next Job:"
							}
						}
					}
				}
			},
			"links": {
				"link_0": {
					"fromOperator": "campaign_0",
					"fromConnector": "output_1",
					"toOperator": "job_1",
					"toConnector": "input_1"
				},
				"link_1": {
					"fromOperator": "job_1",
					"fromConnector": "output_1",
					"toOperator": "job_2",
					"toConnector": "input_1"
				},
				"link_2": {
					"fromOperator": "job_2",
					"fromConnector": "output_1",
					"toOperator": "job_3",
					"toConnector": "input_1"
				},
				"link_3": {
					"fromOperator": "job_3",
					"fromConnector": "output_1",
					"toOperator": "job_4",
					"toConnector": "input_1"
				},
				"link_4": {
					"fromOperator": "job_4",
					"fromConnector": "output_1",
					"toOperator": "job_5",
					"toConnector": "input_1"
				},
				"link_5": {
					"fromOperator": "job_5",
					"fromConnector": "output_1",
					"toOperator": "job_6",
					"toConnector": "input_1"
				},
				"link_6": {
					"fromOperator": "job_6",
					"fromConnector": "output_1",
					"toOperator": "job_7",
					"toConnector": "input_1"
				},
				"link_7": {
					"fromOperator": "job_7",
					"fromConnector": "output_1",
					"toOperator": "job_8",
					"toConnector": "input_1"
				},
				"link_8": {
					"fromOperator": "job_8",
					"fromConnector": "output_1",
					"toOperator": "job_9",
					"toConnector": "input_1"
				},
				"link_9": {
					"fromOperator": "job_9",
					"fromConnector": "output_1",
					"toOperator": "job_10",
					"toConnector": "input_1"
				},
				"link_10": {
					"fromOperator": "job_10",
					"fromConnector": "output_1",
					"toOperator": "job_11",
					"toConnector": "input_1"
				},
				"link_11": {
					"fromOperator": "job_11",
					"fromConnector": "output_1",
					"toOperator": "job_12",
					"toConnector": "input_1"
				},
				"link_12": {
					"fromOperator": "job_12",
					"fromConnector": "output_1",
					"toOperator": "job_13",
					"toConnector": "input_1"
				},
				"link_13": {
					"fromOperator": "job_13",
					"fromConnector": "output_1",
					"toOperator": "job_14",
					"toConnector": "input_1"
				},
				"link_14": {
					"fromOperator": "job_14",
					"fromConnector": "output_1",
					"toOperator": "job_15",
					"toConnector": "input_1"
				},
				"link_15": {
					"fromOperator": "campaign_1",
					"fromConnector": "output_1",
					"toOperator": "job_1",
					"toConnector": "input_1"
				},
				"link_16": {
					"fromOperator": "job_1",
					"fromConnector": "output_1",
					"toOperator": "job_2",
					"toConnector": "inp…