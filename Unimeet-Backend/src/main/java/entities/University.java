package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="university")
public class University {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="UniID")
	private int uniId;
	
	@Column(name="UniName")
	private String uniName;
	
	@ManyToOne
	@JoinColumn(name="ID")
	private UniDept uniDept;

}
