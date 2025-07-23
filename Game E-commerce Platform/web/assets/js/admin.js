/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function filterTable() {
    let input = document.getElementById("tableSearch");
    let filter = input.value.toLowerCase();
    let table = document.getElementById("userTable");
    let tr = table.getElementsByTagName("tr");

    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName("td");
        let found = false;
        for (let j = 1; j < td.length - 1; j++) {
            if (td[j].textContent.toLowerCase().includes(filter)) {
                found = true;
                break;
            }
        }
        tr[i].style.display = found ? "" : "none";
    }
}
