Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15648BD26
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285250; cv=fail; b=QbcbBFWY6TEs5K8mIxxpeh0I8CVZcPjENtk8FFY9snw8lwLFoPzkAwi+UrtnWX5jWAwnQYGdM6DPuToHUh8yWKfKskC70He6tYgw9NZzTtJqINu2laRzO0Q2VMS8uGl2q5l2uxRW+lHUEEKQrQ+UrtWR59fASJ5V1H2TflDABoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285250; c=relaxed/simple;
	bh=NokP5Bs1jyTVT300wwICsCvUQFrawWV3pZSCgdEXwoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFO4BBXHdhJVl0JoqXY2eaJs9kF6YMNp7nU9jmseemY/cr3gmEOpXJdelDoBnTneJrRWen48Cv2C8BoGF3qesMob72ibCwwMzdoe0E8azwNA0otojNNXj43Fm6P+kuDgsEIbN5GrkjcLcpJ7q89ZNFfShNGvBNDc0ILFgH+Yf1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmRnYN0S; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmRnYN0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvo3Kcarc3hvzk5gwGM7cAzyufzi1Dg/pHJ0V14w7QMll414WqNl1XXMB7DwzY+IheuABR3od16H25j1XgXT8dEgp5z1CoOzUOYbrJb1u7IXHHJT+yCe0dmhYsW2H+julWorCwg6zCi1FNt6htTloDLuYdZp6MDezLImUQpaRGgqP3oBqk6dAhwMhufahiqIYPJVe3Hdu5lsuM2qVhQyO2NkqiK2TPwiJtJRLxU2C31MhJ/BhY/JPS/5JzzjRk2wcc5hjnfe+Yg6u2g0iZ5W1O49Srh7HgRXm36RWJbFlv3/ZAE5yuwi9IvraOJuNxwkb0C/yWT/tmNKzqIxnZnk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXBuyOUZ0u9seXj+yW36X9dtyBqb2SH/icTpeMcVLv0=;
 b=CYjLUPsIc0+5t/HHD7bJtNkUM9zdJYY50xKzTDKVmffPdgnZFM4GLeOpnLqQoKTOXa40iT6e1pRaRRAozA2DdALadLVrw53kRZqR6TFKrE/GfPNAvgsyY/tOdMpkRivY8WuNYTy61pDSG/4dpwcoyU+AA+KDMvI2d2mmBYYgVME8+0r2a0LpRcyk166/du8PPIziVGZcth8HfpVA4gRNGf2sjB4ey5U3F4OVExGPqS1YtZ9Zr/00SSBMQCTTVtgS7KIN2V8Z8zm76HbT0tH7rOEHc5PNv/5ckOYY5FLBxwxGfgPfszrUuJTnSKniXe67UmGdWrkIPD5DkQNyz1bNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXBuyOUZ0u9seXj+yW36X9dtyBqb2SH/icTpeMcVLv0=;
 b=hmRnYN0SHvARee48bAbITaNlRAG4Afk9KMdueLusTN4DiHPdyFFP8tR9FbOxtTLQJXo78yOFp0seuMgve708nw9Kd7v3MNvNi+N9UlLTqa/KoMTNlqxrA4UgCs5NE6F56KEL0uq9EZn0Fh0yMBswC/GrKlUtD4whQlTaX02fy50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 17:54:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 17:54:05 +0000
Message-ID: <fb4affaa-0093-4a5d-9591-63700b46e64d@amd.com>
Date: Tue, 1 Sep 2026 12:54:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Call cmd_ready/go_idle for each command
 transmission
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <20260901163217.2749911-1-mario.limonciello@amd.com>
 <apcNU_RLDkrfZraq@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <apcNU_RLDkrfZraq@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:806:22::25) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 421b80eb-5791-4623-1a64-08df0852039e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oV5IcgKqWs2NaMhwDCzVrlWeRqRDiDEByZbu8iDMs2E33amkxW8WhvaC3uw2vT/kXDHhTk/DEXtD8oZvnda59EU6XNXNNK1+0WNlTH01V929OGIVnsoe2uahJ6qd721plH9jOUa4o5UXDAEP43nWWCvKVuPyIgHIcW2qX0+p/8QxbXP+9Y0h/JljnvTdVUzYnR6cCqYNN1IqEtIO7cMFhEtuL9qC3MeJa53MAW65ScM9yp1aV/ASTAqQgbbEumJ7ZJVRgzfQofcGkL+CXdGCkrRvhxzIOPfLaNubYy3w51G8+GsPX55+arbg8j/GKeKMikgmEF8v2uH8kN3hN2+c3br6f4uJRrDzAzXcGzTmQP/ZqsP2QhJgwHTmj7wTMojfdHMQv2kGYI0cOuyEyWtA6tQrNc0csEBXIFmwZ2h13vd57mP5JMW4zwcdIn92t5iDYA7sXQqJ0sq4c8FzhJ/BYkgCtgRxHJWlNRaDbHKljN/uWE1inGt40eYARcsa62s52wzURyQ/ve/OGvuOKsf5GrJ119QzaSSC+Q4KUFvEbP2gSI5ZUo7VH4SCUBX36Ht7MgGcmBP9hR6YF/cDJ2ZIq5y/nRefiJcDYrFSajpHMf57utD6Efe0QaQCX32fRbgk07fWacK9raIcCR1VJxsojsjxWAyLD4Tp4ejqRkoaxDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFDcDQ2ak0rMmZ3Q3R6NWRPWEpXWEpCcUI5aWtQOWIxd0dNY1B4ZHVqb1V5?=
 =?utf-8?B?ZERNSU8ybmRDbjVDbU96QnppL0pZZUxtaTNleDFOdUZiRDNjUVlnK2FSek1j?=
 =?utf-8?B?SkZvQWRadjVCcjZWMlZsWk5tMXIyaXpzN2lRVVAvcUQ5dWxXQ0pvUGVtZklE?=
 =?utf-8?B?M0laZThaN3pzaExiMjR3YlVlek9rZ0t4eDgxbTFTTGtxYmkvNHFMVUh2NzN0?=
 =?utf-8?B?c25Ec0x1a1l6Mkp2bFBQLzFMN0N5K1pxbFpsL2dDejBGMnhmZGNpOWIyK0hn?=
 =?utf-8?B?MWxGdEFxWTF4WTNGSHNYeTZwOThSakJLR0tvQUdnV29ZaUxybFJud1V0bXBm?=
 =?utf-8?B?b3o0Y3drVWN1YXRSVHdlS1FPZ2dJNWFwc2NCbnRaQk51VlBSTmloQWIxRDhv?=
 =?utf-8?B?bGtCRk52M2JmM2s5Y3lyNThQNEkzWmJHV0RQc3AwcGhZQzRZYjY0RGlnUHN6?=
 =?utf-8?B?a0ZDTHRjNW1OZFdMb2V4cjFtUitBajFCTll2NVRBSE9qY0VPa2diTzhRQWp3?=
 =?utf-8?B?Tk1rMmgrUWlvbHFUYUg1dFo5akhSa09LQUt2Ulpzc2ZPMndvRTFWTVJDUncr?=
 =?utf-8?B?akVNMnIzSk5IV2R1WGxkNHEzNFIzOXJ4VGNEODZKRC9WejBXYlRKZUtZdlpS?=
 =?utf-8?B?RDJnaWZLZDNRdlZGNXVFOXBVZzFhSXN6RlJHbkNXdGFINWZ5Z3RVd0FXdC9i?=
 =?utf-8?B?YTBPcVNMcUNFTFVDcXcyMWl4TlNtR0wyYWpPSDcyWitUeWJSY3RkL2szd2Np?=
 =?utf-8?B?NXVOQzdXSWZrQy9BWDV5cENpR0VoRW5sbkRuZHk2Um9xRVpSYWZKbWFCbm54?=
 =?utf-8?B?VTk4VUVscUEwaTN5WXhDM21pUTljTFRJdkRMYmRYMkF4KzVyY1AwVlEvb2Qr?=
 =?utf-8?B?eFFEWk45dFRxV0hrandYQzJkQ1QyWHVZUlRlSXZObjMrVWticlVHa0xkRUNL?=
 =?utf-8?B?VGxkQm1tNmdUdVhQdzF0VVRhVVF5YkJ3MHg5ZEpvNW1maWZlcjdhYjZSTlE2?=
 =?utf-8?B?VFEvWkVyK0l5L0pMbTE4Y1RiWW54YXBwOVpaZWNVZytEZ2tpM2YxYkh6c3Ft?=
 =?utf-8?B?Q2JFQVFNTS8rZ1V4MlBXMUhHVE5OajV0Ykp5dFgrSGNVZHdqaXZPdmxsTm1w?=
 =?utf-8?B?Nlk0UGdrZlRJL1FvZVlydVMzaFFTWWpYMWplcXJ6RUF0MC84MjZiN3NrbWRa?=
 =?utf-8?B?Zlh4ZC94VGVLZ0pKdVQvbzZ4Uy9HTnhxbm5xVTRlZE9vMGxPZWF5TS84dW92?=
 =?utf-8?B?WXA3TXJ2MTJiQy9ucVBNOGtoZ1NmYVQ5K09nRi9tK0hoVnV0Z3VpbmZsSVhD?=
 =?utf-8?B?Qll6WklFNWR4QndmZmMwVUh5STEzdGYzbEdmUklMMUQ1eTQzYWxwOC9rdExx?=
 =?utf-8?B?TitCYllGYm9JSkYrNmtvcm11MHlhbTJQR1lwdmxpV29TdFc4Mndya3ZiQ3cx?=
 =?utf-8?B?OVVvcVB4b2d3Q2R3OVNTTVRhSTBxS0RxM3BpTnhwb3IwditHcEpuRTV5UDY5?=
 =?utf-8?B?V3VyYmRreGF2U1UyL0lzNnVYanBvSVdiUS9jbGliY3NJWklSVTdhUXVVL09p?=
 =?utf-8?B?MnZTeUFleTBuaHh4ZkxuZGhxTlBBNnFEL3pQMStxeE5GNzFwNFh2dFlGUWJw?=
 =?utf-8?B?WVE5bFRkYThkeHZ6RFkybVJrMDhoKzM3eFQybGNqNmtLWU55cUQ1WjZWa2VP?=
 =?utf-8?B?eWNVd1NLeFFDSVpZcEhMZzZoMWx5R1JSWkdjR2FLc21Qak9LMXhkSWJWMnBh?=
 =?utf-8?B?OVFGUkFXZWJJL0k5Rkwzem1PSFZkS0hVQjVUNDJkM3pjL1AxVG1XS3djalg4?=
 =?utf-8?B?Tis2WUUrcnlKbHk1YTlFVUowbEpPNk8wZlplSDgwaE56MXRsdHBCbzY4R29i?=
 =?utf-8?B?ZFFwUEVZdUVZRmpmM1BYR1ozbkV6R2xIbEZPeEtnVUpKcFlobG4vZkMzSUdJ?=
 =?utf-8?B?b3h4eC96MG5Jb3diKzJDWkZJbWdBeG9XZW9IR0o1d1NiemNHb3ZvamFJNXVM?=
 =?utf-8?B?YXlKTlBVQnZ1TG53WnRGZVNkckd0aTJJZk50bCtvTThlQjFZejdQWkplUXdD?=
 =?utf-8?B?TDFnSENTd1B3TEthZmc0OTMzQ1lkTUJvaXdBbHo5YTh0bEs3TThJVkdFcXhY?=
 =?utf-8?B?VGNGQzN1c3VnVHJXVEpCbFJtVDllZk8zTUpQYWxLRFdZb0FyalZsUnZydU5X?=
 =?utf-8?B?bEFEU3lDVWJGOXpkeUhNTW9ITmsrQ0xvTnM4Ymx1S2U2VXpvWWVaRll2alc5?=
 =?utf-8?B?V3poMlJQdTJIOExKOWZpYjVPbm41L3RCNTdreG9WaXU5SjltRDQ3SVB3SGk2?=
 =?utf-8?B?UkZPMVF5VmVyQ0R0ZUs1UnRCQXV0NFJOY08ySHpuNVc5OGpFQzlpQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421b80eb-5791-4623-1a64-08df0852039e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 17:54:05.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGDwUQRS0WnwgdEG3qAssiF8Pz9MxCPV4k5bXDG4PdmR/cMiRDIrMLpfQgHuejxvmO0x1/CirWCzbZUzWQuzNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559



On 9/1/26 12:37, Jarkko Sakkinen wrote:
> On Tue, Sep 01, 2026 at 11:32:15AM -0500, Mario Limonciello wrote:
>> Some TPM implementations, particularly fTPM using the CRB interface,
>> require the TPM to transition through idle and ready states for each
>> command rather than once per session.
>>
>> The current implementation calls cmd_ready once during tpm_chip_start()
>> and go_idle once during tpm_chip_stop(). For fTPM, when multiple commands
>> are sent without per-command idle transitions, subsequent commands timeout
>> as the TPM is waiting for the transition.
>>
>> Fix this by calling cmd_ready before each command and go_idle on all exit
>> paths in tpm_try_transmit(). For TPM implementations that don't require
>> per-command transitions, the callbacks return immediately based on the
>> start method.
>>
>> Remove the now-redundant per-session calls from tpm_chip_start() and
>> tpm_chip_stop() along with their helpers.
>>
>> This resolves timeout errors during TPM initialization on systems where
>> BIOS has already performed TPM startup.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Drop redundant calls
>>   * Update commit message
>> ---
>>   drivers/char/tpm/tpm-chip.c      | 24 ------------------------
>>   drivers/char/tpm/tpm-interface.c | 26 ++++++++++++++++++++++----
>>   2 files changed, 22 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 12b7394b34bdc..0be5dbfaa72eb 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -66,22 +66,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
>>   	chip->locality = -1;
>>   }
>>   
>> -static int tpm_cmd_ready(struct tpm_chip *chip)
>> -{
>> -	if (!chip->ops->cmd_ready)
>> -		return 0;
>> -
>> -	return chip->ops->cmd_ready(chip);
>> -}
>> -
>> -static int tpm_go_idle(struct tpm_chip *chip)
>> -{
>> -	if (!chip->ops->go_idle)
>> -		return 0;
>> -
>> -	return chip->ops->go_idle(chip);
>> -}
>> -
>>   static void tpm_clk_enable(struct tpm_chip *chip)
>>   {
>>   	if (chip->ops->clk_enable)
>> @@ -116,13 +100,6 @@ int tpm_chip_start(struct tpm_chip *chip)
>>   		}
>>   	}
>>   
>> -	ret = tpm_cmd_ready(chip);
>> -	if (ret) {
>> -		tpm_relinquish_locality(chip);
>> -		tpm_clk_disable(chip);
>> -		return ret;
>> -	}
>> -
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_chip_start);
>> @@ -137,7 +114,6 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
>>    */
>>   void tpm_chip_stop(struct tpm_chip *chip)
>>   {
>> -	tpm_go_idle(chip);
>>   	tpm_relinquish_locality(chip);
>>   	tpm_clk_disable(chip);
>>   }
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index f745a098908b3..c5b5b5ba41821 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -113,12 +113,21 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>   		return -E2BIG;
>>   	}
>>   
>> +	if (chip->ops->cmd_ready) {
>> +		rc = chip->ops->cmd_ready(chip);
>> +		if (rc) {
>> +			dev_err(&chip->dev,
>> +				"%s: cmd_ready(): error %d\n", __func__, rc);
>> +			return rc;
>> +		}
>> +	}
> 
> I'd consider retaining tpm_go_idle and do this after arming the command:
> 
> 	chip = chip __free(tpm_go_idle);
> 

Good idea; that would be a lot less cleanup changes.  I'll modify and test.

>> +
>>   	rc = chip->ops->send(chip, buf, bufsiz, count);
>>   	if (rc < 0) {
>>   		if (rc != -EPIPE)
>>   			dev_err(&chip->dev,
>>   				"%s: send(): error %d\n", __func__, rc);
>> -		return rc;
>> +		goto out;
>>   	}
>>   
>>   	/*
>> @@ -152,7 +161,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>   
>>   		if (tpm_chip_req_canceled(chip, status)) {
>>   			dev_err(&chip->dev, "Operation Canceled\n");
>> -			return -ECANCELED;
>> +			rc = -ECANCELED;
>> +			goto out;
>>   		}
>>   
>>   		tpm_msleep(TPM_TIMEOUT_POLL);
>> @@ -168,19 +178,27 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>   
>>   	tpm_chip_cancel(chip);
>>   	dev_err(&chip->dev, "Operation Timed out\n");
>> -	return -ETIME;
>> +	rc = -ETIME;
>> +	goto out;
>>   
>>   out_recv:
>>   	len = chip->ops->recv(chip, buf, bufsiz);
>>   	if (len < 0) {
>>   		rc = len;
>>   		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
>> -		return rc;
>> +		goto out;
>>   	}
>>   out_sync:
>>   	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>>   		rc = -EFAULT;
>>   
>> +out:
>> +	if (chip->ops->go_idle) {
>> +		int idle_rc = chip->ops->go_idle(chip);
>> +		if (idle_rc && !rc)
>> +			rc = idle_rc;
>> +	}
>> +
>>   	return rc ? rc : len;
>>   }
>>   
>> -- 
>> 2.43.0
>>
> 
> BR, Jarkko

