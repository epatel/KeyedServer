<?php

/* ------------------------------------------------------------------
 *
 * Author: Edward Patel, Memention AB, http://memention.com
 *
 * ------------------------------------------------------------------*/

if (isset( $_POST['csum'] ) &&
	isset( $_FILES ) &&
	isset( $_FILES['arch'] ) &&
	md5_file($_FILES['arch']['tmp_name']) === $_POST['csum'] ) {

	system("./KeyedServer \"" . $_FILES['arch']['tmp_name'] . "\"");

} else {

	?> 

	<html>
	<head>
	</head>
	<body>
		Intentionally left blank
	</body>
	</html>

	<?php

}

?>
