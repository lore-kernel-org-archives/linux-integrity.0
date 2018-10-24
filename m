Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CE4ECDE44
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA420833
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 19:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CA420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJYEZz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:25:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbeJYEZy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Oct 2018 00:25:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9OJrnad167522
        for <linux-integrity@vger.kernel.org>; Wed, 24 Oct 2018 15:56:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nauw3b2hj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Oct 2018 15:56:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 24 Oct 2018 20:56:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Oct 2018 20:56:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9OJuJDO6553992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Oct 2018 19:56:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAE3CA4040;
        Wed, 24 Oct 2018 19:56:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26922A4055;
        Wed, 24 Oct 2018 19:56:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.86.180])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Oct 2018 19:56:16 +0000 (GMT)
Subject: Re: Aw: Re: LSS-EU BoF(s) (renamed from LPC 2018)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Peter Huewe <PeterHuewe@gmx.de>,
        Monty Wiseman <montywiseman32@gmail.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, serge@hallyn.com,
        chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        dpsmith@apertussolutions.com
In-Reply-To: <trinity-2564d361-b0c0-44bc-a099-c845e46061a7-1540396532523@3c-app-gmx-bs24>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <1539642523.2867.44.camel@HansenPartnership.com>
         <alpine.LRH.2.21.1810160946210.2779@namei.org>
         <1539691005.11939.258.camel@linux.ibm.com>
         <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
         <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
         <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
         <1540301465.2787.4.camel@HansenPartnership.com>
         <1540301816.5583.187.camel@linux.ibm.com>
         <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
         <trinity-2564d361-b0c0-44bc-a099-c845e46061a7-1540396532523@3c-app-gmx-bs24>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 24 Oct 2018 12:25:19 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102419-0012-0000-0000-000002BD1510
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102419-0013-0000-0000-000020F1201C
Message-Id: <1540398319.3692.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810240166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-10-24 at 17:55 +0200, Peter Huewe wrote:
> Hi,
> what is now the concensus on the BOF(s) time and location?

Supposedly we're meeting in the Moorfoot room at 6Pm.  We're sitting
outside the room now.  (It's past the registration desk.)

Mimi

