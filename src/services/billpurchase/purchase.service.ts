import { Injectable } from '@nestjs/common';
import { PurchaseReportDto } from './dto/purchasereport.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class purchaseService {
    constructor(private readonly db: DatabaseService) { }

    async purchaseReport(payload: PurchaseReportDto, sessionpayload: SessionPayloadDto) {
        try {
            if(payload.account_id === 'null'){
                payload.account_id=sessionpayload.account_id.toString(); 
            }
            var queryResponse = await this.db.executeFunc('select sd_purchasehistory($1,$2,$3,$4,$5,$6,$7,$8)', 'sd_purchasehistory', [parseInt(payload.account_id), payload.from_date, payload.to_date, payload.draw_id, payload.getalldata, payload.filter, sessionpayload.account_id, payload.agent_rate]);
            return queryResponse;
        } catch (error) {
            throw error;
        }
    }
}
