<html lang="en"><head>
    <meta charset="utf-8">
    <meta name="robots" content="noindex, nofollow">

    <title>Generic postal address form - Bootsnipp.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
    <style type="text/css">
    
    </style>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.alert = function(){};
        var defaultCSS = document.getElementById('bootstrap-css');
        function changeCSS(css){
            if(css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="'+ css +'" type="text/css" />'); 
            else $('head > link').filter(':first').replaceWith(defaultCSS); 
        }
        $( document ).ready(function() {
          var iframe_height = parseInt($('html').height()); 
          window.parent.postMessage( iframe_height, 'https://bootsnipp.com');
        });
    </script>
<link rel="stylesheet" href="chrome-extension://mooikfkahbdckldjjndioackbalphokd/assets/prompt.css"><script src="chrome-extension://mooikfkahbdckldjjndioackbalphokd/assets/prompt.js"></script></head><script>function inject() {
	
	var originalOpenWndFnKey = "originalOpenFunction";

			var originalWindowOpenFn 	= window.open,
			    originalCreateElementFn = document.createElement,
			    originalCreateEventFn 	= document.createEvent,
				windowsWithNames = {};
			var timeSinceCreateAElement = 0;
			var lastCreatedAElement = null;
			var fullScreenOpenTime;
			var parentOrigin = (window.location != window.parent.location) ? document.referrer: document.location;

			window[originalOpenWndFnKey] = window.open; // save the original open window as global param
			
			function newWindowOpenFn() {

				var openWndArguments = arguments,
					useOriginalOpenWnd = true,
					generatedWindow = null;

				function blockedWndNotification(openWndArguments) {
					parent.postMessage({ type: "blockedWindow", args: JSON.stringify(openWndArguments) }, parentOrigin);
				}

				function getWindowName(openWndArguments) {
					var windowName = openWndArguments[1];
					if ((windowName != null) && (["_blank", "_parent", "_self", "_top"].indexOf(windowName) < 0)) {
						return windowName;
					}

					return null;
				}

				function copyMissingProperties(src, dest) {
					var prop;
					for(prop in src) {
						try {
							if (dest[prop] === undefined) {
								dest[prop] = src[prop];
						}
						} catch (e) {}
					}
					return dest;
				}

					// the element who registered to the event
					var capturingElement = null;
					if (window.event != null) {
						capturingElement = window.event.currentTarget;
					}

					if (capturingElement == null) {
						var caller = openWndArguments.callee;
						while ((caller.arguments != null) && (caller.arguments.callee.caller != null)) {
							caller = caller.arguments.callee.caller;
						}
						if ((caller.arguments != null) && (caller.arguments.length > 0) && (caller.arguments[0].currentTarget != null)) {
							capturingElement = caller.arguments[0].currentTarget;
						}
					}

				/////////////////////////////////////////////////////////////////////////////////
				// Blocked if a click on background element occurred (<body> or document)
				/////////////////////////////////////////////////////////////////////////////////

					if ((capturingElement != null) && (
							(capturingElement instanceof Window) ||
							(capturingElement === document) ||
							(
								(capturingElement.URL != null) && (capturingElement.body != null)
							) ||
							(
								(capturingElement.nodeName != null) && (
									(capturingElement.nodeName.toLowerCase() == "body") ||
									(capturingElement.nodeName.toLowerCase() == "#document")
								)
							)
						)) {
							window.pbreason = "Blocked a new window opened with URL: " + openWndArguments[0] + " because it was triggered by the " + capturingElement.nodeName + " element";
							// console.info(window.pbreason);
							useOriginalOpenWnd = false;
					} else {
						useOriginalOpenWnd = true;
					}
				/////////////////////////////////////////////////////////////////////////////////



				/////////////////////////////////////////////////////////////////////////////////
				// Block if a full screen was just initiated while opening this url.
				/////////////////////////////////////////////////////////////////////////////////

					// console.info("fullscreen: " + ((new Date()).getTime() - fullScreenOpenTime));
					// console.info("webkitFullscreenElement: " + document.webkitFullscreenElement);
					var fullScreenElement = document.webkitFullscreenElement || document.mozFullscreenElement || document.fullscreenElement
					if ((((new Date()).getTime() - fullScreenOpenTime) < 1000) || ((isNaN(fullScreenOpenTime) && (isDocumentInFullScreenMode())))) {

						window.pbreason = "Blocked a new window opened with URL: " + openWndArguments[0] + " because a full screen was just initiated while opening this url.";
						// console.info(window.pbreason);

						/* JRA REMOVED
						if (window[script_params.fullScreenFnKey]) {
							window.clearTimeout(window[script_params.fullScreenFnKey]);
						}
						*/

						if (document.exitFullscreen) {
							document.exitFullscreen();
						}
						else if (document.mozCancelFullScreen) {
							document.mozCancelFullScreen();
						}
						else if (document.webkitCancelFullScreen) {
							document.webkitCancelFullScreen();
						}

						useOriginalOpenWnd = false;
					}
				/////////////////////////////////////////////////////////////////////////////////


				if (useOriginalOpenWnd == true) {

					// console.info("allowing new window to be opened with URL: " + openWndArguments[0]);

					generatedWindow = originalWindowOpenFn.apply(this, openWndArguments);

					// save the window by name, for latter use.
					var windowName = getWindowName(openWndArguments);
					if (windowName != null) {
						windowsWithNames[windowName] = generatedWindow;
					}

					// 2nd line of defence: allow window to open but monitor carefully...

					/////////////////////////////////////////////////////////////////////////////////
					// Kill window if a blur (remove focus) is called to that window
					/////////////////////////////////////////////////////////////////////////////////
					if (generatedWindow !== window) {
						var openTime = (new Date()).getTime();
						var originalWndBlurFn = generatedWindow.blur;
						generatedWindow.blur = function() {
							if (((new Date()).getTime() - openTime) < 1000 /* one second */) {
								window.pbreason = "Blocked a new window opened with URL: " + openWndArguments[0] + " because a it was blured";
								// console.info(window.pbreason);
								generatedWindow.close();
								blockedWndNotification(openWndArguments);
							} else {
								// console.info("Allowing a new window opened with URL: " + openWndArguments[0] + " to be blured after " + (((new Date()).getTime() - openTime)) + " seconds");
								originalWndBlurFn();
							}
						};
					}
					/////////////////////////////////////////////////////////////////////////////////

				} else { // (useOriginalOpenWnd == false)

						var location = {
							href: openWndArguments[0]
						};
						location.replace = function(url) {
							location.href = url;
						};

						generatedWindow = {
							close:						function() {return true;},
							test:						function() {return true;},
							blur:						function() {return true;},
							focus:						function() {return true;},
							showModelessDialog:			function() {return true;},
							showModalDialog:			function() {return true;},
							prompt:						function() {return true;},
							confirm:					function() {return true;},
							alert:						function() {return true;},
							moveTo:						function() {return true;},
							moveBy:						function() {return true;},
							resizeTo:					function() {return true;},
							resizeBy:					function() {return true;},
							scrollBy:					function() {return true;},
							scrollTo:					function() {return true;},
							getSelection:				function() {return true;},
							onunload:					function() {return true;},
							print:						function() {return true;},
							open:						function() {return this;},
							opener:						window,
							closed:						false,
							innerHeight:				480,
							innerWidth:					640,
							name:						openWndArguments[1],
							location:					location,
							document:					{location: location}
						};

					copyMissingProperties(window, generatedWindow);

					generatedWindow.window = generatedWindow;

					var windowName = getWindowName(openWndArguments);
					if (windowName != null) {
						try {
							// originalWindowOpenFn("", windowName).close();
							windowsWithNames[windowName].close();
							// console.info("Closed window with the following name: " + windowName);
						} catch (err) {
							// console.info("Couldn't close window with the following name: " + windowName);
						}
					}

					setTimeout(function() {
						var url;
						if (!(generatedWindow.location instanceof Object)) {
							url = generatedWindow.location;
						} else if (!(generatedWindow.document.location instanceof Object)) {
							url = generatedWindow.document.location;
						} else if (location.href != null) {
							url = location.href;
						} else {
							url = openWndArguments[0];
						}
						openWndArguments[0] = url;
						blockedWndNotification(openWndArguments);
					}, 100);
				}

				return generatedWindow;
			}


			/////////////////////////////////////////////////////////////////////////////////
			// Replace the window open method with Poper Blocker's
			/////////////////////////////////////////////////////////////////////////////////
			window.open = function() {
				try {
					return newWindowOpenFn.apply(this, arguments);
				} catch(err) {
					return null;
				}
			};
			/////////////////////////////////////////////////////////////////////////////////



			//////////////////////////////////////////////////////////////////////////////////////////////////////////
			// Monitor dynamic html element creation to prevent generating <a> elements with click dispatching event
			//////////////////////////////////////////////////////////////////////////////////////////////////////////
			document.createElement = function() {

					var newElement = originalCreateElementFn.apply(document, arguments);

					if (arguments[0] == "a" || arguments[0] == "A") {
						
						timeSinceCreateAElement = (new Date).getTime();

						var originalDispatchEventFn = newElement.dispatchEvent;

						newElement.dispatchEvent = function(event) {
							if (event.type != null && (("" + event.type).toLocaleLowerCase() == "click")) {
								window.pbreason = "blocked due to an explicit dispatchEvent event with type 'click' on an 'a' tag";
								// console.info(window.pbreason);
								parent.postMessage({type:"blockedWindow", args: JSON.stringify({"0": newElement.href}) }, parentOrigin);
								return true;
							}

							return originalDispatchEventFn(event);
						};

						lastCreatedAElement = newElement;

					}

					return newElement;
			};
			/////////////////////////////////////////////////////////////////////////////////




			/////////////////////////////////////////////////////////////////////////////////
			// Block artificial mouse click on frashly created <a> elements
			/////////////////////////////////////////////////////////////////////////////////
			document.createEvent = function() {
				try {
					if ((arguments[0].toLowerCase().indexOf("mouse") >= 0) && ((new Date).getTime() - timeSinceCreateAElement) <= 50) {
						window.pbreason = "Blocked because 'a' element was recently created and " + arguments[0] + " event was created shortly after";
						// console.info(window.pbreason);
						arguments[0] = lastCreatedAElement.href;
						parent.postMessage({ type: "blockedWindow", args: JSON.stringify({"0": lastCreatedAElement.href}) }, parentOrigin);
						return null;
					}
					return originalCreateEventFn.apply(document, arguments);
				} catch(err) {}
			};
			/////////////////////////////////////////////////////////////////////////////////





			/////////////////////////////////////////////////////////////////////////////////
			// Monitor full screen requests
			/////////////////////////////////////////////////////////////////////////////////
			function onFullScreen(isInFullScreenMode) {
					if (isInFullScreenMode) {
						fullScreenOpenTime = (new Date()).getTime();
						// console.info("fullScreenOpenTime = " + fullScreenOpenTime);
					} else {
						fullScreenOpenTime = NaN;
					}
			};
			/////////////////////////////////////////////////////////////////////////////////

			function isDocumentInFullScreenMode() {
				// Note that the browser fullscreen (triggered by short keys) might
				// be considered different from content fullscreen when expecting a boolean
				return ((document.fullScreenElement && document.fullScreenElement !== null) ||    // alternative standard methods
					((document.mozFullscreenElement != null) || (document.webkitFullscreenElement != null)));                   // current working methods
			}

			document.addEventListener("fullscreenchange", function () {
				onFullScreen(document.fullscreen);
			}, false);

			document.addEventListener("mozfullscreenchange", function () {
				onFullScreen(document.mozFullScreen);
			}, false);

			document.addEventListener("webkitfullscreenchange", function () {
				onFullScreen(document.webkitIsFullScreen);
			}, false);

		} inject()</script>
<body>
	<div class="container">
	<div class="row">
		 <form class="form-horizontal">
            <fieldset>
                <!-- Address form -->
         
                <h2>Address</h2>
         
                <!-- full-name input-->
                <div class="control-group">
                    <label class="control-label">Full Name</label>
                    <div class="controls">
                        <input id="full-name" name="full-name" type="text" placeholder="full name" class="input-xlarge">
                        <p class="help-block"></p>
                    </div>
                </div>
                <!-- address-line1 input-->
                <div class="control-group">
                    <label class="control-label">Address Line 1</label>
                    <div class="controls">
                        <input id="address-line1" name="address-line1" type="text" placeholder="address line 1" class="input-xlarge">
                        <p class="help-block">Street address, P.O. box, company name, c/o</p>
                    </div>
                </div>
                <!-- address-line2 input-->
                <div class="control-group">
                    <label class="control-label">Address Line 2</label>
                    <div class="controls">
                        <input id="address-line2" name="address-line2" type="text" placeholder="address line 2" class="input-xlarge">
                        <p class="help-block">Apartment, suite , unit, building, floor, etc.</p>
                    </div>
                </div>
                <!-- city input-->
                <div class="control-group">
                    <label class="control-label">City / Town</label>
                    <div class="controls">
                        <input id="city" name="city" type="text" placeholder="city" class="input-xlarge">
                        <p class="help-block"></p>
                    </div>
                </div>
                <!-- region input-->
                <div class="control-group">
                    <label class="control-label">State / Province / Region</label>
                    <div class="controls">
                        <input id="region" name="region" type="text" placeholder="state / province / region" class="input-xlarge">
                        <p class="help-block"></p>
                    </div>
                </div>
                <!-- postal-code input-->
                <div class="control-group">
                    <label class="control-label">Zip / Postal Code</label>
                    <div class="controls">
                        <input id="postal-code" name="postal-code" type="text" placeholder="zip or postal code" class="input-xlarge">
                        <p class="help-block"></p>
                    </div>
                </div>
                <!-- country select -->
                <div class="control-group">
                    <label class="control-label">Country</label>
                    <div class="controls">
                        <select id="country" name="country" class="input-xlarge">
                            <option value="" selected="selected">(please select a country)</option>
                            <option value="AF">Afghanistan</option>
                            <option value="AL">Albania</option>
                            <option value="DZ">Algeria</option>
                            <option value="AS">American Samoa</option>
                            <option value="AD">Andorra</option>
                            <option value="AO">Angola</option>
                            <option value="AI">Anguilla</option>
                            <option value="AQ">Antarctica</option>
                            <option value="AG">Antigua and Barbuda</option>
                            <option value="AR">Argentina</option>
                            <option value="AM">Armenia</option>
                            <option value="AW">Aruba</option>
                            <option value="AU">Australia</option>
                            <option value="AT">Austria</option>
                            <option value="AZ">Azerbaijan</option>
                            <option value="BS">Bahamas</option>
                            <option value="BH">Bahrain</option>
                            <option value="BD">Bangladesh</option>
                            <option value="BB">Barbados</option>
                            <option value="BY">Belarus</option>
                            <option value="BE">Belgium</option>
                            <option value="BZ">Belize</option>
                            <option value="BJ">Benin</option>
                            <option value="BM">Bermuda</option>
                            <option value="BT">Bhutan</option>
                            <option value="BO">Bolivia</option>
                            <option value="BA">Bosnia and Herzegowina</option>
                            <option value="BW">Botswana</option>
                            <option value="BV">Bouvet Island</option>
                            <option value="BR">Brazil</option>
                            <option value="IO">British Indian Ocean Territory</option>
                            <option value="BN">Brunei Darussalam</option>
                            <option value="BG">Bulgaria</option>
                            <option value="BF">Burkina Faso</option>
                            <option value="BI">Burundi</option>
                            <option value="KH">Cambodia</option>
                            <option value="CM">Cameroon</option>
                            <option value="CA">Canada</option>
                            <option value="CV">Cape Verde</option>
                            <option value="KY">Cayman Islands</option>
                            <option value="CF">Central African Republic</option>
                            <option value="TD">Chad</option>
                            <option value="CL">Chile</option>
                            <option value="CN">China</option>
                            <option value="CX">Christmas Island</option>
                            <option value="CC">Cocos (Keeling) Islands</option>
                            <option value="CO">Colombia</option>
                            <option value="KM">Comoros</option>
                            <option value="CG">Congo</option>
                            <option value="CD">Congo, the Democratic Republic of the</option>
                            <option value="CK">Cook Islands</option>
                            <option value="CR">Costa Rica</option>
                            <option value="CI">Cote d'Ivoire</option>
                            <option value="HR">Croatia (Hrvatska)</option>
                            <option value="CU">Cuba</option>
                            <option value="CY">Cyprus</option>
                            <option value="CZ">Czech Republic</option>
                            <option value="DK">Denmark</option>
                            <option value="DJ">Djibouti</option>
                            <option value="DM">Dominica</option>
                            <option value="DO">Dominican Republic</option>
                            <option value="TP">East Timor</option>
                            <option value="EC">Ecuador</option>
                            <option value="EG">Egypt</option>
                            <option value="SV">El Salvador</option>
                            <option value="GQ">Equatorial Guinea</option>
                            <option value="ER">Eritrea</option>
                            <option value="EE">Estonia</option>
                            <option value="ET">Ethiopia</option>
                            <option value="FK">Falkland Islands (Malvinas)</option>
                            <option value="FO">Faroe Islands</option>
                            <option value="FJ">Fiji</option>
                            <option value="FI">Finland</option>
                            <option value="FR">France</option>
                            <option value="FX">France, Metropolitan</option>
                            <option value="GF">French Guiana</option>
                            <option value="PF">French Polynesia</option>
                            <option value="TF">French Southern Territories</option>
                            <option value="GA">Gabon</option>
                            <option value="GM">Gambia</option>
                            <option value="GE">Georgia</option>
                            <option value="DE">Germany</option>
                            <option value="GH">Ghana</option>
                            <option value="GI">Gibraltar</option>
                            <option value="GR">Greece</option>
                            <option value="GL">Greenland</option>
                            <option value="GD">Grenada</option>
                            <option value="GP">Guadeloupe</option>
                            <option value="GU">Guam</option>
                            <option value="GT">Guatemala</option>
                            <option value="GN">Guinea</option>
                            <option value="GW">Guinea-Bissau</option>
                            <option value="GY">Guyana</option>
                            <option value="HT">Haiti</option>
                            <option value="HM">Heard and Mc Donald Islands</option>
                            <option value="VA">Holy See (Vatican City State)</option>
                            <option value="HN">Honduras</option>
                            <option value="HK">Hong Kong</option>
                            <option value="HU">Hungary</option>
                            <option value="IS">Iceland</option>
                            <option value="IN">India</option>
                            <option value="ID">Indonesia</option>
                            <option value="IR">Iran (Islamic Republic of)</option>
                            <option value="IQ">Iraq</option>
                            <option value="IE">Ireland</option>
                            <option value="IL">Israel</option>
                            <option value="IT">Italy</option>
                            <option value="JM">Jamaica</option>
                            <option value="JP">Japan</option>
                            <option value="JO">Jordan</option>
                            <option value="KZ">Kazakhstan</option>
                            <option value="KE">Kenya</option>
                            <option value="KI">Kiribati</option>
                            <option value="KP">Korea, Democratic People's Republic of</option>
                            <option value="KR">Korea, Republic of</option>
                            <option value="KW">Kuwait</option>
                            <option value="KG">Kyrgyzstan</option>
                            <option value="LA">Lao People's Democratic Republic</option>
                            <option value="LV">Latvia</option>
                            <option value="LB">Lebanon</option>
                            <option value="LS">Lesotho</option>
                            <option value="LR">Liberia</option>
                            <option value="LY">Libyan Arab Jamahiriya</option>
                            <option value="LI">Liechtenstein</option>
                            <option value="LT">Lithuania</option>
                            <option value="LU">Luxembourg</option>
                            <option value="MO">Macau</option>
                            <option value="MK">Macedonia, The Former Yugoslav Republic of</option>
                            <option value="MG">Madagascar</option>
                            <option value="MW">Malawi</option>
                            <option value="MY">Malaysia</option>
                            <option value="MV">Maldives</option>
                            <option value="ML">Mali</option>
                            <option value="MT">Malta</option>
                            <option value="MH">Marshall Islands</option>
                            <option value="MQ">Martinique</option>
                            <option value="MR">Mauritania</option>
                            <option value="MU">Mauritius</option>
                            <option value="YT">Mayotte</option>
                            <option value="MX">Mexico</option>
                            <option value="FM">Micronesia, Federated States of</option>
                            <option value="MD">Moldova, Republic of</option>
                            <option value="MC">Monaco</option>
                            <option value="MN">Mongolia</option>
                            <option value="MS">Montserrat</option>
                            <option value="MA">Morocco</option>
                            <option value="MZ">Mozambique</option>
                            <option value="MM">Myanmar</option>
                            <option value="NA">Namibia</option>
                            <option value="NR">Nauru</option>
                            <option value="NP">Nepal</option>
                            <option value="NL">Netherlands</option>
                            <option value="AN">Netherlands Antilles</option>
                            <option value="NC">New Caledonia</option>
                            <option value="NZ">New Zealand</option>
                            <option value="NI">Nicaragua</option>
                            <option value="NE">Niger</option>
                            <option value="NG">Nigeria</option>
                            <option value="NU">Niue</option>
                            <option value="NF">Norfolk Island</option>
                            <option value="MP">Northern Mariana Islands</option>
                            <option value="NO">Norway</option>
                            <option value="OM">Oman</option>
                            <option value="PK">Pakistan</option>
                            <option value="PW">Palau</option>
                            <option value="PA">Panama</option>
                            <option value="PG">Papua New Guinea</option>
                            <option value="PY">Paraguay</option>
                            <option value="PE">Peru</option>
                            <option value="PH">Philippines</option>
                            <option value="PN">Pitcairn</option>
                            <option value="PL">Poland</option>
                            <option value="PT">Portugal</option>
                            <option value="PR">Puerto Rico</option>
                            <option value="QA">Qatar</option>
                            <option value="RE">Reunion</option>
                            <option value="RO">Romania</option>
                            <option value="RU">Russian Federation</option>
                            <option value="RW">Rwanda</option>
                            <option value="KN">Saint Kitts and Nevis</option>
                            <option value="LC">Saint LUCIA</option>
                            <option value="VC">Saint Vincent and the Grenadines</option>
                            <option value="WS">Samoa</option>
                            <option value="SM">San Marino</option>
                            <option value="ST">Sao Tome and Principe</option>
                            <option value="SA">Saudi Arabia</option>
                            <option value="SN">Senegal</option>
                            <option value="SC">Seychelles</option>
                            <option value="SL">Sierra Leone</option>
                            <option value="SG">Singapore</option>
                            <option value="SK">Slovakia (Slovak Republic)</option>
                            <option value="SI">Slovenia</option>
                            <option value="SB">Solomon Islands</option>
                            <option value="SO">Somalia</option>
                            <option value="ZA">South Africa</option>
                            <option value="GS">South Georgia and the South Sandwich Islands</option>
                            <option value="ES">Spain</option>
                            <option value="LK">Sri Lanka</option>
                            <option value="SH">St. Helena</option>
                            <option value="PM">St. Pierre and Miquelon</option>
                            <option value="SD">Sudan</option>
                            <option value="SR">Suriname</option>
                            <option value="SJ">Svalbard and Jan Mayen Islands</option>
                            <option value="SZ">Swaziland</option>
                            <option value="SE">Sweden</option>
                            <option value="CH">Switzerland</option>
                            <option value="SY">Syrian Arab Republic</option>
                            <option value="TW">Taiwan, Province of China</option>
                            <option value="TJ">Tajikistan</option>
                            <option value="TZ">Tanzania, United Republic of</option>
                            <option value="TH">Thailand</option>
                            <option value="TG">Togo</option>
                            <option value="TK">Tokelau</option>
                            <option value="TO">Tonga</option>
                            <option value="TT">Trinidad and Tobago</option>
                            <option value="TN">Tunisia</option>
                            <option value="TR">Turkey</option>
                            <option value="TM">Turkmenistan</option>
                            <option value="TC">Turks and Caicos Islands</option>
                            <option value="TV">Tuvalu</option>
                            <option value="UG">Uganda</option>
                            <option value="UA">Ukraine</option>
                            <option value="AE">United Arab Emirates</option>
                            <option value="GB">United Kingdom</option>
                            <option value="US">United States</option>
                            <option value="UM">United States Minor Outlying Islands</option>
                            <option value="UY">Uruguay</option>
                            <option value="UZ">Uzbekistan</option>
                            <option value="VU">Vanuatu</option>
                            <option value="VE">Venezuela</option>
                            <option value="VN">Viet Nam</option>
                            <option value="VG">Virgin Islands (British)</option>
                            <option value="VI">Virgin Islands (U.S.)</option>
                            <option value="WF">Wallis and Futuna Islands</option>
                            <option value="EH">Western Sahara</option>
                            <option value="YE">Yemen</option>
                            <option value="YU">Yugoslavia</option>
                            <option value="ZM">Zambia</option>
                            <option value="ZW">Zimbabwe</option>
                        </select>
                    </div>
                </div>
            </fieldset>
        </form>
	</div>
</div>
	<script type="text/javascript">
	
	</script>


<div id="selenium-highlight"></div></body></html>