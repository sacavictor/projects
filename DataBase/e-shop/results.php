<html>
<head>
<title>Afisare Rezultate</title>

<style>
body {
    font-family: 'Roboto', sans-serif;
    background-color: #1f1f1f;
    color: #ffffff;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

h1 {
    color: #00bfff;
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 15px;
	margin-left:20px;
    text-transform: uppercase;
}

table {
    border-collapse: collapse;
    width: 75%;
    margin: 20px auto;
}

th, td {
    border: 1px solid #333;
    padding: 15px;
    text-align: left;
}

th {
    background-color: #00bfff;
    color: #ffffff;
}

tr:nth-child(even) {
    background-color: #222;
}
</style>
</head>
<body>
<h1>Rezultatele cautarii</h1>
<?php
	$servername = "localhost";
	$username = "admin";
	$password = "password";
	$database = "devices";
	
	$connect = mysqli_connect($servername, $username, $password, $database);
	if(!$connect){
		die("Eroare conexiune");
	}
	
	function procedure($procedurename){
		global $connect;
		 $sql = "CALL $procedurename()";
		$result = mysqli_query($connect, $sql);

		if(!$result)
			die("Eroare la executarea interogarii");
		
	echo "<table border='1'>";
	echo "<tr>";
	while ($header = $result->fetch_field()) {
		echo "<td>{$header->name}</td>";
	}
	echo "</tr>";

	$rand = mysqli_fetch_row($result);
	$coloane = count($rand);

	while ($rand != 0) {
		echo "<tr>";
		for ($i = 0; $i < $coloane; $i++) {
			echo "<td>{$rand[$i]}</td>";
		}
		echo "</tr>";
		$rand = mysqli_fetch_row($result);
	}
echo "</table>";
	}
	
	if(isset($_GET['idx']) == TRUE)
		$idxNumber = intval($_GET['idx']);
	else
		$idxNumber = 0;
	
	switch($idxNumber){
		case 1:
			$procName = "imprimantaColor";
			procedure($procName);
			break;
		
		case 2:
			$procName = "LaptopDiag";
			procedure($procName);
			break;
		
		case 3:
			$procName = "imprimantaLaserColor";
			procedure($procName);
			break;
		case 4:
			$procName = "perechiPC";
			procedure($procName);
			break;
		case 5:
			$procName = "imprimantaPretModel";
			procedure($procName);
			break;
		case 6:
			$procName = "ModelPCPretMin";
			procedure($procName);
			break;
		case 7:
			$procName = "pretMediuImprimantaTip";
			procedure($procName);
			break;
		case 8:
			$procName = "LaptopPretMax";
			procedure($procName);
			break;
		default:
			die("Eroare");
	}
?></body>
</html>

