Return-Path: <SRS0=NqBx=NA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E8C67863
	for <linux-integrity@archiver.kernel.org>; Sat, 20 Oct 2018 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630C22154C
	for <linux-integrity@archiver.kernel.org>; Sat, 20 Oct 2018 18:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630C22154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJUChp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:37:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727350AbeJUCho (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 20 Oct 2018 22:37:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KIOKtu144789
        for <linux-integrity@vger.kernel.org>; Sat, 20 Oct 2018 14:26:26 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7x0d3nt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 20 Oct 2018 14:26:26 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 20 Oct 2018 12:26:26 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Oct 2018 12:26:21 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9KIQKVG63701050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Oct 2018 11:26:20 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 855B37805E;
        Sat, 20 Oct 2018 18:26:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4889278064;
        Sat, 20 Oct 2018 18:26:16 +0000 (GMT)
Received: from [9.77.200.130] (unknown [9.77.200.130])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 20 Oct 2018 18:26:15 +0000 (GMT)
Subject: Re: LPC 2018
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
 <20181011154847.GA5978@mail.hallyn.com>
 <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
 <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
 <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
 <alpine.LRH.2.21.1810160833560.14147@namei.org>
 <1539642523.2867.44.camel@HansenPartnership.com>
 <alpine.LRH.2.21.1810160946210.2779@namei.org>
 <1539691005.11939.258.camel@linux.ibm.com>
 <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Sat, 20 Oct 2018 23:53:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18102018-0020-0000-0000-00000E7D057B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009908; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105522; UDB=6.00572405; IPR=6.00885572;
 MB=3.00023840; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-20 18:26:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102018-0021-0000-0000-00006371A600
Message-Id: <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810200173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/18/2018 05:35 AM, Jarkko Sakkinen wrote:
> On Tue, 16 Oct 2018, Mimi Zohar wrote:
>> On Tue, 2018-10-16 at 09:46 +1100, James Morris wrote:
>>> On Mon, 15 Oct 2018, James Bottomley wrote:
>>>
>>>>> What about a TPM BoF at LSS
>>>>
>>>> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
>>>> a Wednesday overlap, though, so Wednesday would work.
>>>
>>> LSS is Thurs+Fri, but we may have a quorum for Weds.
>>
>> Some of us are arriving Wed.  Perhaps try scheduling it later in the
>> day Wed.
>>
>> Mimi
>
> Yeah, could be possible (also arriving that day). Do not really care if
> we talk about the same stuff that I want to talk in my presentation
> (namely channel encryption). I was thinking to talk about it as an 
> introduction to the topic but this way around I could summarize the
> BoF.
>
> I hope the time is late as possible though on Wed.
>
> /Jarkko

Do we have a time finalized to meet on Wednesday ? I will also be joining.

Thanks & Regards,
     - Nayna

