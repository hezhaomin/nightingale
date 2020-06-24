package mcache

import (
	"fmt"
	"sync"
	"github.com/didi/nightingale/src/model"
)

// sacache 是给报警事件聚合用得原因是 同一报警是无状态得 且无法标识其唯一性 故报警产生时会生成 hashid:uuid
// 如果获取hashid得value为0则为新产生报警 需要插入数据库一条信息 如果不为空且状态为alert则说明是同一系列得报警不做操作
// 如果报警恢复则设置key为hashid得值 为0
type SaCacheMap struct {
	sync.RWMutex
	Data map[uint64]string
}

var SaCache *SaCacheMap

func NewSaCache() *SaCacheMap {
	sc :=  &SaCacheMap{
		Data: make(map[uint64]string),
	}
	sas ,err:= model.SaFilter("recover_time",0)
    if err != nil {
       return sc
	}
	for _,sa := range  sas {
		sc.Data[sa.HashId] = sa.Uuid
	}
	fmt.Printf("%v",sc)
	return sc
}



func (sc *SaCacheMap) ScGet(hashid uint64) (string, bool) {
	value, exists := sc.Data[hashid]
	return value, exists
}
func (sc *SaCacheMap) ScSet(hashid uint64, uuid string) {
	sc.Lock()
	defer sc.Unlock()
	sc.Data[hashid] = uuid
	return
}