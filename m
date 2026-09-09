Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CB579835
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970163; cv=fail; b=h4dt60ywlo1yBqdjXj4bxBSGUuDtvN3BXd9zO6kk/vajiaB5WFoD8yHcJ/jrH0jyojHckmhtvdNr0nbToamUALu6Rp5zu6Khosg2ORewGJk8lVFp6vRHpUMB+tAvEYoimD0xGUaM0ofSYvTKhjUcjqbS9RJvkbzoMGFxNDnOl6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970163; c=relaxed/simple;
	bh=A0gZsTpdSp72alArvaKHxOBpHl5QhibyxF73V1hsWAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsQwH+CHjTsjOeAdhmYyMOfT0EqKWrwDOCDyJXHk9o7dHwgYu661ompqO8r7I4qePTqOSMj2RrJZxQC9od4V6iWzHlg2ocyde9nTX09EKPRyhozbkzWXC3FFmBWbsOXbZfiikuNRyrh0otgPU7TpX0zr7hw6g5Za1Ye02Zbv/Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0NGjv7Q; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0NGjv7Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzmG1qEvy1WrF+cVvPvVKrk21K3hdj/tcjiQGKURMgAKEgWLesGM1/bNFsN+H0vnHOHYptOuXQ7osNyvbWh7IcFJsq2G6Lte1In7CVZdnpa9flxtxXyXYqsqiL/ICQ6x03cA6cs+YFpTqcdPt2Dwha9OPRBNCHdbL8/Ub16L+GI+xR1niJ09AptDFHDYAljdKp+1p1H2+cdP6jt08dsHqlTlKJGwmxaDacqlb5vCv4rkN3q4mC4X3Y9XZjjvSSSCQf3YWR+wxv4t5CyYqcJg+Fs9TRNUpnhvpOP+DZzXKjGpM+1H4pAPVnXz1NUJhkN7X3ju2KDL9lCxkUhrPZ3F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DVF/qcmogU5Ns2v0OCdp1XNH/bn7qNo9mc++guEdPg=;
 b=aHqX3XyORDBfB03E3GEHhTeg5fB43nlN+CmXbPAkBO1/OwWQPnkQJtQf0mdC3FAbrwLcK8Xpkh8LVpODvbd+E3VNCFCtnGSsLsHaxEdedJ+R699ezr9rXD3WsZvyO6ia9+sG5YUybkuQsh+DF/kCoEp7+qln+uSIcgd/v7z1QbaYy2TjJVRh8SaCS4HK9MrvEBPZsbJOxNPyFr7l3llixVAvLs6HtELX1RGI7BNGuICpAOxA5Bpfp3wOmVhi6jSF/Jer3NJhdAjmlVoaBAzPgXQbv2UxfPxyPs/+05+qVd6UVrPRtCollHJ8sX9/sH/fNFLNtZU9hAKc3b2O5oKvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DVF/qcmogU5Ns2v0OCdp1XNH/bn7qNo9mc++guEdPg=;
 b=f0NGjv7Ql5fzeiIfWUZrY+leiIm4zWhJIDezabaBSAU60CYSeoKGbD7Tg8I5scDJeV7uL2flTT9LQpzcGuccEMeWuvd6tiOqZBkfR97irt3YWWKWVTlT1VuXzDT9eXpYpkbRMSoWo1RurNcitbAeW2mx94uDkmFd8/Pu7cmhgIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 16:09:14 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:09:13 +0000
Message-ID: <4ed5b724-02d9-411e-b393-d40fe9af40ad@amd.com>
Date: Wed, 9 Sep 2026 11:08:59 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3] tpm: Call cmd_ready/go_idle for each command
 transmission
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <20260901213723.3017371-1-mario.limonciello@amd.com>
 <apdX965qlXd3M-5i@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <apdX965qlXd3M-5i@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: bb036536-d2e6-4734-d606-08df0e8cb0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OuAxQuDs+xGXzjtUihvdFcbWK06Z6YXTRmKkmtvxgz0YbgTULrDc2x/RrYiPcb0Cn1zB9aaZ0vqPBlS7a86qFc9L0AR9l4INhScNqJqF7meoj/EQpqHFHMdJ9T18NwGXtuqGS0zNVcjasYxxMdq1AGg7FVtatAFnaH9119bMn8b7KX43S1+zf6/uEswzKNfXQz11gHsfMR9TKz4pEaiN8D9B+RCSW5DzpgRHA9WdxBSN2t+kmTbRJ4i+eEVwBDCfkBbGfH9sFYJ53W8NCf9xd7xZ3J4g92GGYp/Lk705N1te9fjF7ekbOleEUrwffNoqG0AUoNm4nCCf3kwAu5VMCdythlEkgLQpvY3/HcK5HxNQt0TpvGX3dKVkOO94d3EayP4vMAi/zvXRfjEnife+hs323B+ekSun8Ok4LdCBXqov/iEyUfjkA2AiFU/vYE4D3S/bRZn/pqd9Spbd8ImzkPLtA8W+vHxI1vtZnUZsin4qbLhhVVTwTHo2dpuZ4Wm/OtmCjopZ/UEh8EiogtQ55Do7YYugI8jiTsYwq+DfyLJWm6zOs6opMLA/U56CEyBJqnrIxRTJQV373QWOJnVucY4gqwukXanLZX5HLbJsrkJbEDz3+8+eSHsv6uALMtZSwLDDne6htft6PuJTGb3tNVB17iWzh5JdaDPoGRtgfic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnJuVmpmN21BWjBjdXVad0VFRHd6K0JBaSt3TkFMeHVzMUNIdklTbzdiTFlt?=
 =?utf-8?B?SE9ieXRyRUQvLzNxWlpTSUtQQkpadG9rQVlNV0FTMTA2NXA2dGtEVWp0cEFS?=
 =?utf-8?B?MWM0UzM5T1Z5TmZjRFJKRSs4ZWkzeFp6ZEtrcERLQ1J0SlQvTmdmd0xtMGFN?=
 =?utf-8?B?Y1dNVjc1Z1JDMGJ6dVM1NDFDNkNiMjE4YWtMQWdHbDFleVZIWXJuY2JkN08z?=
 =?utf-8?B?MW5VekFGOXB4Uk03Zzhob1JxUklEamxlcEpJS1QxdVQ1UUVQRFR0UnVEbW9B?=
 =?utf-8?B?UENhcmdkb0hyZ2kxZk5OUUQvcmJqdzNPeW52UityVHRKYlp4d0Z3UXpVYjk1?=
 =?utf-8?B?eTJBYUZMRm96aHBZNEQyc3JHWHpodnRVQlZETDY3cVNkeUxkOVoybFlRYUsr?=
 =?utf-8?B?RlJ3c0JQR1UzSm44TmFGTmxleHlDMk1WTGtuZTV0YXkwK2RsejlYZ3owS1Ns?=
 =?utf-8?B?MDZVS1FFVU1OZVMvMWZ6OGg2MlpJRmZ4dmgyb3BMVzNGU1lWWXJGRVpXKzVX?=
 =?utf-8?B?SURRQlNidmVqcERpN3l2SHNVdTUwZTJ2bFQraFYvSXlsNE9EclpvNUhzUjFk?=
 =?utf-8?B?aFFEN1l5UGlkOFRBcFBaRHFtVU9uWnc0bVYvTkYvUVFZN3lWdGN4WUJwdllR?=
 =?utf-8?B?KzN4QTlHd01oNXJ2c1k4elJzbnJGNURkMzBrVkFJYWdrZVdPMk5hZTRLMVhE?=
 =?utf-8?B?TStFMEtnYW5WQVJzcGsrYzQ5TmJuVmlBVHNhczRnOHg2dFNrSDNuVEN0VlhF?=
 =?utf-8?B?dGwzMjFsMkdIcXFQUnhYN3Uxb056OHRJL2lKUC9QcUsxU0F4UURJSFU3aCtt?=
 =?utf-8?B?ZE8rWDZ4SHFQQ3g5eXRGM2tVUC9TOExjUktKNVR3cExCY1JHQkJjTVJUU29i?=
 =?utf-8?B?aDZlOFdvOVZtend0SmNTMlhSRlQ4QzY3NVBwWUY0RzBIRzczazF1bnJnNHFM?=
 =?utf-8?B?dHBDc1B4LzJ0QmUraWpMWFJvOVA4YVJidVV0VDl5cjdhTGw2d05YaWRURlF2?=
 =?utf-8?B?RmVWblF6VDJqdXdVSUVHWVFNZzdjZGhIam5YbHozNXRTQ2FZWjhSWCtEbGNX?=
 =?utf-8?B?Uk5Nci92eDM2QVI1UlA3enBoc1VqblhaUzQ0ZmU5cWYrNjl2amJNbjZpWkUz?=
 =?utf-8?B?WWFTM0RnVXF2ZUNFVXQrdGV3bkxGR2ZwSEs4Wnc1a2R4MGdVcWlVYmpWNHJR?=
 =?utf-8?B?RHViZFVnQ0J4T1V3OE1vc3RLRGpDV2VneE5vU1JkSGprc0xaZGc0M2FWdGNS?=
 =?utf-8?B?OTVKV1dOSE1GcHR1MjViOStMVEpnc09YYUdmeCt4YzkrNWs0RkZYWm9VWU54?=
 =?utf-8?B?WWFGaUU4cVFCVGJoRlBicDdQb1M4R1E4NVlESDZ2N2xEZjd0WkZZQ3o5RlNM?=
 =?utf-8?B?UjZ1SnJHbmdjcDFtVTJpTEVMTVJPSmtpcXUvZk5LcjZrUFFRWG5LREFKcWE3?=
 =?utf-8?B?UGhuZVZIbEhrMEQzblMrU1Y4WkZDbUNPKzlhWWozMWlwbFEvSEhDRkZUS2lt?=
 =?utf-8?B?d1ZodDJIZllIMEhQVkwzeWYxajJadGFTcFRSL1AzTWx2N3QrbDhjRyt5aGsx?=
 =?utf-8?B?Zlh1Zi9BWEp0bEg4cmlxcmxJbXJ3UEhFUG9xaVphWXhRVnVBaXB5a29Ia0xQ?=
 =?utf-8?B?TGVhdU9RelFpbi9idWRmanNyeGZVUjN4TUF1QkRWcmsvZStxS2EzKzFrWmFH?=
 =?utf-8?B?R1RwVFJ2NDJLdGJocTVabGx2R201dzNsQzZReFdJenZ2cVhTem1aeXJLYVRM?=
 =?utf-8?B?UDZMSmI0ZVhoYkRDUGJRY3NMR1FiR1U3RlVkQlZPTG1YZkYwZXpkU3lTRVZY?=
 =?utf-8?B?d3N1ZXdBOFBnTUM0ajVLbkNyenVnRitKSW5tUGkyUDExZ1VmaVRiRzlHRVQr?=
 =?utf-8?B?akx2NW5BOWxJMmtRaW4ydnZmSEczY2sydTJpNzRSRDFURXpVR3hVNnAwWUZ1?=
 =?utf-8?B?cVVGVENSeFZya3lkbHFPTENyU0tRaHBKMHo2SjVtdVYvWktTTzE4ZVI1Q2pT?=
 =?utf-8?B?b3dQSE1INklZMStSbGw4NnJsQmt1ZGxsZnIrSlJTMzBXekxmay9mYnVmRnlR?=
 =?utf-8?B?R0ZaREdwWjY1clhXcm9wL2U4Q1JpdDhtUUZOWnphcHhuVlNFY1ZJTHE0dS81?=
 =?utf-8?B?cFYrVGZ5OSttanhTcHdEa09paUFWU1EybEdIcm92cFZ1c29KM2QyUGloWms4?=
 =?utf-8?B?K1JXSFRzemtGQVlHUGZwMjRpWmFIMVBjenBXRnkyQW5aMGN2MnkrNUlWYnpS?=
 =?utf-8?B?TmFIWmYyNE5Ib0o3WjE5UlF2L2dyRm4vUlRsQmRENUpCSUtoY21xSUpRdFRO?=
 =?utf-8?Q?J8CuK15WzroE/Y03bJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb036536-d2e6-4734-d606-08df0e8cb0e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:09:13.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlBESHqt7IUK7MWG1VgPRnj875Ao/9xb/NLspJHEAc4ZHCl6AJYDx2Y//KipgaMWWRC6t51lOcv2eoPhS8uJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771



On 9/1/26 17:55, Jarkko Sakkinen wrote:
> On Tue, Sep 01, 2026 at 04:37:22PM -0500, Mario Limonciello wrote:
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
>> v3:
>>   * Use __free() to clean up
>> v2:
>>   * Drop redundant calls
>>   * Update commit message
>> ---
>>   drivers/char/tpm/tpm-chip.c      | 24 ------------------------
>>   drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
>>   2 files changed, 21 insertions(+), 24 deletions(-)
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
>> index f745a098908b3..8d434d7fa5bab 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -19,6 +19,7 @@
>>    * calls to msleep.
>>    */
>>   
>> +#include <linux/cleanup.h>
>>   #include <linux/poll.h>
>>   #include <linux/slab.h>
>>   #include <linux/mutex.h>
>> @@ -89,8 +90,16 @@ static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
>>   	return status_masked == chip->ops->req_complete_val;
>>   }
>>   
>> +static void tpm_go_idle(struct tpm_chip *chip)
>> +{
>> +	if (chip->ops->go_idle)
>> +		chip->ops->go_idle(chip);
>> +}
>> +DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
>> +
>>   static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>   {
>> +	struct tpm_chip *chip_idle __free(tpm_go_idle) = NULL;
>>   	struct tpm_header *header = buf;
>>   	int rc;
>>   	ssize_t len = 0;
>> @@ -113,6 +122,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
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
>> +
>> +	/* Ensure go_idle() is called on every exit path from here on. */
>> +	chip_idle = chip;
>> +
>>   	rc = chip->ops->send(chip, buf, bufsiz, count);
>>   	if (rc < 0) {
>>   		if (rc != -EPIPE)
>> -- 
>> 2.43.0
>>
> 
> This is now much better as it addition adds better guarantees that
> resources always get released after use no matter how this function
> is modified later on.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

Thanks.  If no other concerns, can this be picked up now?

