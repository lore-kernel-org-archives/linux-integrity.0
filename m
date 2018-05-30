Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752995AbeE3NEs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 09:04:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UCuUY7094883
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 09:04:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9snwg9f8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 09:04:47 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 09:04:46 -0400
Subject: Re: [PATCH 6/8] integrity: Factor out common part of
 integrity_audit_msg()
To: Steve Grubb <sgrubb@redhat.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-7-stefanb@linux.vnet.ibm.com> <2600105.j2Wzuo56oP@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 09:04:41 -0400
MIME-Version: 1.0
In-Reply-To: <2600105.j2Wzuo56oP@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6184c964-9dbb-1f0a-2db7-27a6f2b2bba7@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/29/2018 05:32 PM, Steve Grubb wrote:
> On Thursday, May 24, 2018 4:11:03 PM EDT Stefan Berger wrote:
>> Factor out a common part of integrity_audit_msg() that others
>> can also call.
> After all of these changes, do you mind sending an example event for testing/
> review?

Adding example to 5/8 since this patch here doesn't change any records.
