module AdminHelper 
    def admin_count
        User.where(role: 'admin').count
    end

    def worker_count
        Worker.where(status: 'approved').count
    end

    def customer_count
        User.where(role: 'customer').count
    end

    def skill_count
        Skill.count
    end

end
