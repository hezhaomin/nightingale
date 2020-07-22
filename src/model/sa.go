package model

import (
	"fmt"
	"time"

)

type Sa struct {
	Id            int64     `json:"id"`
	Sid           int64     `json:"sid"`
	Metric           string     `json:"metric"`
	AlertTime        int64       `json:"alert_time"`
	RecoverTime      int64   `json:"recover_time"`
	TimeInterval     int64    `json:"time_interval"`
	Uuid string `json:"uuid"`
	HashId           uint64    `json:"hashid"  xorm:"hashid"`
	Effective        int64     `json:"effective"` //0 无效 1 有效
	ReasonInfo    string    `json:"reason_info"` // effective = 0 时的原因
	User          string    `json:"user"` // 最后修改人
	Endpoint          string    `json:"endpoint" xorm:"endpoint"`
	EndpointAlias          string    `json:"endpoint_alias" xorm:"endpoint_alias"`
	Created       time.Time `json:"created" xorm:"created"`

}

func SaFilter(col string, value interface{}) ([]*Sa,error) {
	sas := []*Sa{}
	err := DB["mon"].Where(col+"=?", value).Find(&sas)
	return sas, err
}

func SaGet(col string, value interface{}) (*Sa, error) {
	var obj Sa
	has, err := DB["mon"].Where(col+"=?", value).Get(&obj)
	if err != nil {
		return nil, err
	}

	if !has {
		return nil, nil
	}

	return &obj, nil
}
func SaveSa(sa *Sa) error {


	_ , err := DB["mon"].Insert(sa)
	return err
}

func SaRecoverSave(sa *Sa ) error {
	obj,err := SaGet("uuid",sa.Uuid)
	if err!= nil {
		return err
	}

	ti := sa.RecoverTime - obj.AlertTime
	fmt.Printf("%v \n",ti)
	sql := "update sa set recover_time=?,time_interval=? where uuid=?"
	_, err = DB["mon"].Exec(sql,sa.RecoverTime, ti, sa.Uuid)
	return err
}