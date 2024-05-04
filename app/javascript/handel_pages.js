document.getElementById('day_night_select').addEventListener('change', function() {
    const hoursPerDay = parseInt(document.getElementById('hours_per_day_input').value);
    const dayNight = this.value;
    const timingSelect = document.querySelector('#timing_scroll select');
    timingSelect.innerHTML = '';
  
    let startHour, endHour;
  
    if (dayNight === 'Day') {
      startHour = 4;
      endHour = 17;
    }
   else if (dayNight === 'Night') {
      startHour = 18;
      endHour = 29; 
    }
  
    for (let i = startHour; i <= endHour - hoursPerDay; i++) {
      const option = document.createElement('option');
      option.value = i % 24;
      option.textContent = `${i % 24}:00 - ${(i + hoursPerDay) % 24}:00`;
      timingSelect.appendChild(option);
    }
  });
  
   document.getElementById('hours_per_day_input').addEventListener('input', function() {
    document.getElementById('day_night_select').dispatchEvent(new Event('change'));
  });
